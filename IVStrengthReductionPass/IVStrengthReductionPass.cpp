#include "llvm/ADT/SmallVector.h"
#include "llvm/Analysis/LoopInfo.h"
#include "llvm/Analysis/LoopPass.h"
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
    bool Changed = false;

    for (Loop *L : LI)
      Changed |= processLoop(L);

    return Changed;
  }

  bool processLoop(Loop *L) {
    bool Changed = false;
    BasicBlock *Header = L->getHeader();
    std::vector<Instruction *> ToErase;

    for (auto &I : *Header) {
      if (PHINode *PN = dyn_cast<PHINode>(&I)) {
        errs() << "Found IV: " << PN->getName() << "\n";

        SmallVector<User *, 8> Users(PN->user_begin(), PN->user_end());

        for (User *U : Users) {
          if (auto *BinOp = dyn_cast<BinaryOperator>(U)) {
            Value *Op0 = BinOp->getOperand(0);
            Value *Op1 = BinOp->getOperand(1);

            ConstantInt *Const = dyn_cast<ConstantInt>(Op0);
            Value *Var = Op1;
            if (!Const) {
              Const = dyn_cast<ConstantInt>(Op1);
              Var = Op0;
            }
            if (!Const)
              continue;

            IRBuilder<> Builder(BinOp);
            Value *NewVal = nullptr;

            // MUL
            if (BinOp->getOpcode() == Instruction::Mul) {
              int64_t C = Const->getSExtValue();
              if (isPowerOf2_64(std::abs(C))) {
                // Shift
                unsigned ShiftAmt = Log2_64(std::abs(C));
                NewVal = Builder.CreateShl(
                    Var, ConstantInt::get(Const->getType(), ShiftAmt),
                    "shl_by_pow2");
                if (C < 0)
                  NewVal = Builder.CreateNeg(NewVal, "neg_after_shl");
              } else {
                // Add
                Value *Sum = nullptr;
                for (int64_t k = 0; k < std::abs(C); k++) {
                  if (!Sum)
                    Sum = Var;
                  else
                    Sum = Builder.CreateAdd(Sum, Var, "add_for_mul");
                }
                if (C < 0)
                  Sum = Builder.CreateNeg(Sum, "neg_mul");
                NewVal = Sum;
              }
            }
            // DIV
            else if (BinOp->getOpcode() == Instruction::SDiv ||
                     BinOp->getOpcode() == Instruction::UDiv) {
              int64_t C = Const->getSExtValue();
              if (C == 0)
                continue;
              if (isPowerOf2_64(std::abs(C))) {
                unsigned ShiftAmt = Log2_64(std::abs(C));
                if (BinOp->getOpcode() == Instruction::UDiv)
                  NewVal = Builder.CreateLShr(
                      Var, ConstantInt::get(Const->getType(), ShiftAmt),
                      "lshr_by_pow2");
                else
                  NewVal = Builder.CreateAShr(
                      Var, ConstantInt::get(Const->getType(), ShiftAmt),
                      "ashr_by_pow2");
                if (C < 0)
                  NewVal = Builder.CreateNeg(NewVal, "neg_after_shr");
              }
            }

            if (NewVal) {
              BinOp->replaceAllUsesWith(NewVal);
              ToErase.push_back(BinOp);
              Changed = true;
              errs() << "Applied IVSR on: " << *NewVal << "\n";
            }
          }
        }
      }
    }

    for (Instruction *I : ToErase)
      I->eraseFromParent();

    for (Loop *SubL : L->getSubLoops())
      Changed |= processLoop(SubL);

    return Changed;
  }

  void getAnalysisUsage(AnalysisUsage &AU) const override {
    AU.addRequired<LoopInfoWrapperPass>();
  }
};

char IVStrengthReductionPass::ID = 0;
static RegisterPass<IVStrengthReductionPass>
    X("our-ivsr-pass", "IV Strength Reduction Pass", false, false);

} // namespace