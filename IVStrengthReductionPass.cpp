#include "llvm/Pass.h"
#include "llvm/IR/Function.h"
#include "llvm/IR/Instructions.h"
#include "llvm/IR/IRBuilder.h"
#include "llvm/IR/Constants.h"
#include "llvm/Analysis/LoopInfo.h"
#include "llvm/Transforms/Utils/BasicBlockUtils.h"
#include "llvm/Support/raw_ostream.h"

#include <vector>
#include <set>

using namespace llvm;

namespace {

struct IVStrengthReductionPass : public FunctionPass {
    static char ID;
    IVStrengthReductionPass() : FunctionPass(ID) {}

    void getAnalysisUsage(AnalysisUsage &AU) const override {
        AU.addRequired<LoopInfoWrapperPass>();
        AU.setPreservesAll();
    }

private:
    static std::string valueToString(Value *V) {
        if (!V) return "<null>";
        std::string tmp;
        raw_string_ostream rso(tmp);
        V->print(rso);
        return rso.str();
    }

    void applyStrengthReduction(PHINode *phi, Loop *loop, ConstantInt *stepConst) {
        BasicBlock *header = loop->getHeader();
        BasicBlock *preheader = loop->getLoopPreheader();
        BasicBlock *latch = loop->getLoopLatch();
        if (!preheader || !latch) return;

        // Novi PHI node za add-chain
        PHINode *newPhi = PHINode::Create(phi->getType(), 2, "", header->getFirstNonPHI());
        Value *initVal = (phi->getIncomingBlock(0) == preheader) ? phi->getIncomingValue(0)
                                                                 : phi->getIncomingValue(1);
        newPhi->addIncoming(initVal, preheader);

        IRBuilder<> Builder(latch->getTerminator());
        Value *newAdd = Builder.CreateAdd(newPhi, stepConst);
        newPhi->addIncoming(newAdd, latch);

        replaceDependentMul(phi, newPhi, loop);
    }

    void replaceDependentMul(PHINode *oldPhi, PHINode *newPhi, Loop *loop) {
        SmallVector<Instruction*, 8> toReplace;
        for (auto *U : oldPhi->users()) {
            if (Instruction *user = dyn_cast<Instruction>(U)) {
                if (loop->contains(user) && user->getOpcode() == Instruction::Mul)
                    toReplace.push_back(user);
            }
        }

        for (Instruction *mulInst : toReplace) {
            Value *otherOp = mulInst->getOperand(0) == oldPhi ? mulInst->getOperand(1) : mulInst->getOperand(0);
            IRBuilder<> Builder(mulInst);
            Value *replacement = Builder.CreateMul(newPhi, otherOp);
            mulInst->replaceAllUsesWith(replacement);
            mulInst->eraseFromParent();
        }
    }

    bool detectAndApplyIV(PHINode *phi, Loop *loop, std::set<PHINode*> &processed) {
        if (processed.count(phi)) return false; // već obrađen

        BasicBlock *preheader = loop->getLoopPreheader();
        BasicBlock *latch = loop->getLoopLatch();
        if (!preheader || !latch || phi->getNumIncomingValues() != 2) return false;

        Value *incoming0 = phi->getIncomingValue(0);
        Value *incoming1 = phi->getIncomingValue(1);
        BasicBlock *block0 = phi->getIncomingBlock(0);
        BasicBlock *block1 = phi->getIncomingBlock(1);

        Value *initVal = nullptr;
        Value *stepExpr = nullptr;

        if (block0 == preheader && block1 == latch) { initVal = incoming0; stepExpr = incoming1; }
        else if (block1 == preheader && block0 == latch) { initVal = incoming1; stepExpr = incoming0; }
        else return false;

        BinaryOperator *binOp = dyn_cast<BinaryOperator>(stepExpr);
        if (!binOp) return false;

        ConstantInt *stepConst = nullptr;
        if (binOp->getOperand(0) == phi) stepConst = dyn_cast<ConstantInt>(binOp->getOperand(1));
        else if (binOp->getOperand(1) == phi) stepConst = dyn_cast<ConstantInt>(binOp->getOperand(0));
        else return false;

        if (!stepConst) return false;

        // Primenjuj transformaciju
        applyStrengthReduction(phi, loop, stepConst);

        // Log samo jednom
        errs() << "IV detected and strength reduction applied:\n"
               << "  PHI: " << *phi
               << "\n  init: " << valueToString(initVal)
               << ", step: " << stepConst->getSExtValue() << "\n";

        processed.insert(phi);
        return true;
    }

public:
    bool runOnFunction(Function &F) override {
        LoopInfo &LI = getAnalysis<LoopInfoWrapperPass>().getLoopInfo();
        errs() << "Running IV strength reduction on function: " << F.getName() << "\n";

        for (Loop *loop : LI) {
            BasicBlock *header = loop->getHeader();
            std::set<PHINode*> processed;

            // Sakupi sve originalne PHI nodove u header-u
            SmallVector<PHINode*, 8> originalPhis;
            for (auto &I : *header)
                if (PHINode *phi = dyn_cast<PHINode>(&I))
                    originalPhis.push_back(phi);

            // Iteriraj samo po originalnim PHI nodovima
            for (PHINode *phi : originalPhis)
                detectAndApplyIV(phi, loop, processed);
        }

        return true;
    }
};

} // namespace

char IVStrengthReductionPass::ID = 0;
static RegisterPass<IVStrengthReductionPass> X(
    "our-ivsr-pass", "Strength reduction of induction variables");
