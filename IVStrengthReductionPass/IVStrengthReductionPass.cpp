#include <map>
#include <tuple>
#include <vector>

#include "llvm/ADT/SmallPtrSet.h"
#include "llvm/Analysis/LoopInfo.h"
#include "llvm/Analysis/LoopPass.h"
#include "llvm/IR/Constants.h"
#include "llvm/IR/Function.h"
#include "llvm/IR/IRBuilder.h"
#include "llvm/IR/Instructions.h"
#include "llvm/Pass.h"
#include "llvm/Support/MathExtras.h" 
#include "llvm/Support/raw_ostream.h"

using namespace llvm;

namespace {

struct IVStrengthReductionPass : public FunctionPass {
  static char ID;
  IVStrengthReductionPass() : FunctionPass(ID) {}

  bool runOnFunction(Function &F) override {
    LoopInfo &LI = getAnalysis<LoopInfoWrapperPass>().getLoopInfo();

    std::vector<Instruction *> ToRemove;
    SmallPtrSet<Instruction *, 16> ToRemoveSet;

    std::map<Value *, std::tuple<Value *, Value *, int>> IndVarMap;

    for (Loop *L : LI) collectIndVarsRecursive(L, IndVarMap);

    for (Loop *L : LI) processLoop(L, IndVarMap, ToRemove, ToRemoveSet);

    for (Instruction *I : ToRemove) {
      if (!I) continue;
      if (I->getParent()) {
        errs() << "Erasing: " << *I << "\n";
        I->eraseFromParent();
      }
    }

    return !ToRemove.empty();
  }

  void collectIndVarsRecursive(
      Loop *L,
      std::map<Value *, std::tuple<Value *, Value *, int>> &IndVarMap) {
    BasicBlock *Header = L->getHeader();

    for (auto &I : *Header) {
      if (PHINode *PN = dyn_cast<PHINode>(&I)) {
        Value *StepVal = nullptr;

        for (User *U : PN->users()) {
          if (auto *BinOp = dyn_cast<BinaryOperator>(U)) {
            if (BinOp->getOpcode() == Instruction::Add &&
                (BinOp->getOperand(0) == PN || BinOp->getOperand(1) == PN)) {
              StepVal = (BinOp->getOperand(0) == PN) ? BinOp->getOperand(1)
                                                     : BinOp->getOperand(0);
              break;
            }
          }
        }

        IndVarMap[&I] = std::make_tuple(PN, StepVal, 0);

        errs() << "Found IV: " << PN->getName();
        if (StepVal) errs() << " (step=" << *StepVal << ")";
        errs() << " in loop header " << Header->getName() << "\n";
      }
    }

    for (Loop *SubLoop : L->getSubLoops())
      collectIndVarsRecursive(SubLoop, IndVarMap);
  }

  void processLoop(
      Loop *L, std::map<Value *, std::tuple<Value *, Value *, int>> &IndVarMap,
      std::vector<Instruction *> &ToRemove,
      SmallPtrSet<Instruction *, 16> &ToRemoveSet) {
    BasicBlock *Header = L->getHeader();
    BasicBlock *Preheader = L->getLoopPreheader();
    BasicBlock *Latch = L->getLoopLatch();

    if (!Preheader || !Latch) return;

    for (BasicBlock *BB : L->blocks()) {
      std::vector<Instruction *> Insts;
      for (Instruction &I : *BB) Insts.push_back(&I);

      for (Instruction *Inst : Insts) {
        if (!Inst || ToRemoveSet.count(Inst)) continue;

        if (BinaryOperator *BinOp = dyn_cast<BinaryOperator>(Inst)) {
          if (BinOp->getOpcode() == Instruction::Mul) {
            Value *Op0 = BinOp->getOperand(0);
            Value *Op1 = BinOp->getOperand(1);

            ConstantInt *ConstOperand = nullptr;
            Value *VarOperand = nullptr;

            if (isa<ConstantInt>(Op0)) {
              ConstOperand = cast<ConstantInt>(Op0);
              VarOperand = Op1;
            } else if (isa<ConstantInt>(Op1)) {
              ConstOperand = cast<ConstantInt>(Op1);
              VarOperand = Op0;
            }

            if (ConstOperand && VarOperand) {
              int64_t C = ConstOperand->getSExtValue();

              if (llvm::isPowerOf2_64(std::abs(C))) {
                unsigned ShiftAmt = llvm::Log2_64(std::abs(C));
                IRBuilder<> Builder(BinOp);

                Value *Shifted = Builder.CreateShl(
                    VarOperand,
                    ConstantInt::get(ConstOperand->getType(), ShiftAmt),
                    "shl_by_pow2");

                if (C < 0)
                  Shifted = Builder.CreateNeg(Shifted, "neg_after_shl");

                BinOp->replaceAllUsesWith(Shifted);

                errs() << "Replaced mul-by-" << C << " with shift-left-by "
                       << ShiftAmt << " on: " << *BinOp << "\n";

                if (!ToRemoveSet.count(BinOp)) {
                  ToRemove.push_back(BinOp);
                  ToRemoveSet.insert(BinOp);
                }

                continue;  
              }
            }

            Value *Op0_IV = BinOp->getOperand(0);
            Value *Op1_IV = BinOp->getOperand(1);
            Value *IndVar = nullptr;
            ConstantInt *ConstOp_IV = nullptr;

            if (IndVarMap.count(Op0_IV) && isa<ConstantInt>(Op1_IV)) {
              IndVar = Op0_IV;
              ConstOp_IV = cast<ConstantInt>(Op1_IV);
            } else if (IndVarMap.count(Op1_IV) && isa<ConstantInt>(Op0_IV)) {
              IndVar = Op1_IV;
              ConstOp_IV = cast<ConstantInt>(Op0_IV);
            } else {
              continue;
            }

            int C_IV = ConstOp_IV->getSExtValue();
            Value *StepVal = std::get<1>(IndVarMap[IndVar]);
            Value *ScaledStep = nullptr;

            IRBuilder<> LatchBuilder(Latch->getTerminator());
            if (StepVal) {
              if (auto *CI = dyn_cast<ConstantInt>(StepVal)) {
                ScaledStep = ConstantInt::get(IndVar->getType(),
                                              CI->getSExtValue() * C_IV);
              } else {
                ScaledStep = LatchBuilder.CreateMul(
                    StepVal, ConstantInt::get(IndVar->getType(), C_IV));
              }
            } else {
              ScaledStep = ConstantInt::get(IndVar->getType(), C_IV);
            }

            PHINode *NewIV =
                PHINode::Create(IndVar->getType(), 2, "ivsr", &Header->front());
            NewIV->addIncoming(ConstantInt::get(IndVar->getType(), 0),
                               Preheader);

            Value *Add = LatchBuilder.CreateAdd(NewIV, ScaledStep);
            NewIV->addIncoming(Add, Latch);

            BinOp->replaceAllUsesWith(NewIV);

            if (!ToRemoveSet.count(BinOp)) {
              ToRemove.push_back(BinOp);
              ToRemoveSet.insert(BinOp);
            }

            errs() << "Replaced mul with IVSR on: " << *BinOp << "\n";
          }  
          else if (BinOp->getOpcode() == Instruction::SDiv ||
                   BinOp->getOpcode() == Instruction::UDiv) {
            Value *Op0 = BinOp->getOperand(0);
            Value *Op1 = BinOp->getOperand(1);

            ConstantInt *ConstOperand = dyn_cast<ConstantInt>(Op1);
            if (!ConstOperand) continue; 

            int64_t C = ConstOperand->getSExtValue();
            if (C == 0) continue;  

            if (llvm::isPowerOf2_64(std::abs(C))) {
              unsigned ShiftAmt = llvm::Log2_64(std::abs(C));
              IRBuilder<> Builder(BinOp);

              Value *Shifted = nullptr;

              if (BinOp->getOpcode() == Instruction::UDiv) {
                Shifted = Builder.CreateLShr(
                    Op0, ConstantInt::get(ConstOperand->getType(), ShiftAmt),
                    "lshr_by_pow2");
              } else {
                Shifted = Builder.CreateAShr(
                    Op0, ConstantInt::get(ConstOperand->getType(), ShiftAmt),
                    "ashr_by_pow2");
              }


              if (C < 0) Shifted = Builder.CreateNeg(Shifted, "neg_after_shr");

              BinOp->replaceAllUsesWith(Shifted);

              errs() << "Replaced div-by-" << C << " with shift-right-by "
                     << ShiftAmt << " on: " << *BinOp << "\n";

              if (!ToRemoveSet.count(BinOp)) {
                ToRemove.push_back(BinOp);
                ToRemoveSet.insert(BinOp);
              }

              continue;  
            }
          }
        }
      }
    }

    for (Loop *SubLoop : L->getSubLoops())
      processLoop(SubLoop, IndVarMap, ToRemove, ToRemoveSet);
  }

  void getAnalysisUsage(AnalysisUsage &AU) const override {
    AU.addRequired<LoopInfoWrapperPass>();
  }
};

char IVStrengthReductionPass::ID = 0;
static RegisterPass<IVStrengthReductionPass> X("our-ivsr-pass",
                                               "IV Strength Reduction Pass",
                                               false, false);

}  
