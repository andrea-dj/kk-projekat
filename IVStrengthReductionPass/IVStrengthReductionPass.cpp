#include "llvm/Pass.h"
#include "llvm/IR/Function.h"
#include "llvm/IR/Instructions.h"
#include "llvm/IR/IRBuilder.h"
#include "llvm/Analysis/LoopInfo.h"
#include "llvm/Analysis/LoopPass.h"
#include "llvm/IR/Constants.h"
#include "llvm/Support/raw_ostream.h"
#include "llvm/ADT/SmallPtrSet.h"

#include <map>
#include <tuple>
#include <vector>

using namespace llvm;

namespace {

struct IVStrengthReductionPass : public FunctionPass {
    static char ID;
    IVStrengthReductionPass() : FunctionPass(ID) {}

    bool runOnFunction(Function &F) override {
        LoopInfo &LI = getAnalysis<LoopInfoWrapperPass>().getLoopInfo();

        std::vector<Instruction*> ToRemove;
        SmallPtrSet<Instruction*, 16> ToRemoveSet;

        std::map<Value*, std::tuple<Value*, Value*, int>> IndVarMap;

        for (Loop *L : LI)
            collectIndVarsRecursive(L, IndVarMap);

        for (Loop *L : LI)
            processLoop(L, IndVarMap, ToRemove, ToRemoveSet);

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
        std::map<Value*, std::tuple<Value*, Value*, int>> &IndVarMap) {

        BasicBlock *Header = L->getHeader();

        for (auto &I : *Header) {
            if (PHINode *PN = dyn_cast<PHINode>(&I)) {
                Value *StepVal = nullptr;

                for (User *U : PN->users()) {
                    if (auto *BinOp = dyn_cast<BinaryOperator>(U)) {
                        if (BinOp->getOpcode() == Instruction::Add &&
                            (BinOp->getOperand(0) == PN || BinOp->getOperand(1) == PN)) {

                            StepVal = (BinOp->getOperand(0) == PN)
                                ? BinOp->getOperand(1)
                                : BinOp->getOperand(0);
                            break; 
                        }
                    }
                }

                IndVarMap[&I] = std::make_tuple(PN, StepVal, 0);

                errs() << "Found IV: " << PN->getName();
                if (StepVal)
                    errs() << " (step=" << *StepVal << ")";
                errs() << " in loop header " << Header->getName() << "\n";
            }
        }

        for (Loop *SubLoop : L->getSubLoops())
            collectIndVarsRecursive(SubLoop, IndVarMap);
    }

    void processLoop(
        Loop *L,
        std::map<Value*, std::tuple<Value*, Value*, int>> &IndVarMap,
        std::vector<Instruction*> &ToRemove,
        SmallPtrSet<Instruction*, 16> &ToRemoveSet) {

        BasicBlock *Header = L->getHeader();
        BasicBlock *Preheader = L->getLoopPreheader();
        BasicBlock *Latch = L->getLoopLatch();

        if (!Preheader || !Latch)
            return;

        for (BasicBlock *BB : L->blocks()) {
            std::vector<Instruction*> Insts;
            for (Instruction &I : *BB)
                Insts.push_back(&I);

            for (Instruction *Inst : Insts) {
                if (!Inst || ToRemoveSet.count(Inst)) continue;

                if (BinaryOperator *BinOp = dyn_cast<BinaryOperator>(Inst)) {
                    if (BinOp->getOpcode() == Instruction::Mul) {
                        Value *Op0 = BinOp->getOperand(0);
                        Value *Op1 = BinOp->getOperand(1);
                        Value *IndVar = nullptr;
                        ConstantInt *ConstOperand = nullptr;

                        if (IndVarMap.count(Op0) && isa<ConstantInt>(Op1)) {
                            IndVar = Op0;
                            ConstOperand = cast<ConstantInt>(Op1);
                        } else if (IndVarMap.count(Op1) && isa<ConstantInt>(Op0)) {
                            IndVar = Op1;
                            ConstOperand = cast<ConstantInt>(Op0);
                        } else {
                            continue;
                        }

                        int C = ConstOperand->getSExtValue();
                        Value *StepVal = std::get<1>(IndVarMap[IndVar]);
                        Value *ScaledStep = nullptr;

                        IRBuilder<> LatchBuilder(Latch->getTerminator());
                        if (StepVal) {
                            if (auto *CI = dyn_cast<ConstantInt>(StepVal)) {
                                ScaledStep = ConstantInt::get(IndVar->getType(),
                                        CI->getSExtValue() * C);
                            } else {
                                ScaledStep = LatchBuilder.CreateMul(
                                    StepVal,
                                    ConstantInt::get(IndVar->getType(), C));
                            }
                        } else {
                            ScaledStep = ConstantInt::get(IndVar->getType(), C);
                        }


                        PHINode *NewIV = PHINode::Create(
                            IndVar->getType(), 2, "ivsr", &Header->front());
                        NewIV->addIncoming(ConstantInt::get(IndVar->getType(), 0), Preheader);

                        Value *Add = LatchBuilder.CreateAdd(NewIV, ScaledStep);
                        NewIV->addIncoming(Add, Latch);

                        BinOp->replaceAllUsesWith(NewIV);

                        if (!ToRemoveSet.count(BinOp)) {
                            ToRemove.push_back(BinOp);
                            ToRemoveSet.insert(BinOp);
                        }

                        errs() << "Replaced mul with IVSR on: " << *BinOp << "\n";
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
static RegisterPass<IVStrengthReductionPass> X(
    "our-ivsr-pass", "IV Strength Reduction Pass", false, false);

} // namespace
