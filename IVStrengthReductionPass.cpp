#include "llvm/Pass.h"
#include "llvm/IR/Function.h"
#include "llvm/IR/Instructions.h"
#include "llvm/IR/IRBuilder.h"
#include "llvm/IR/Constants.h"
#include "llvm/Analysis/LoopInfo.h"
#include "llvm/Transforms/Utils/BasicBlockUtils.h"
#include "llvm/Support/raw_ostream.h"

#include <map>
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
    struct IndVarInfo {
        Value *base = nullptr;
        int64_t additive = 0;
        int64_t multiplicative = 1;
        int64_t step = 0; // stride
    };

    std::map<Value*, IndVarInfo> indVarMap;

    bool isConstInt(Value *V) { return isa<ConstantInt>(V); }
    int64_t getConstInt(Value *V) { return cast<ConstantInt>(V)->getSExtValue(); }

    static std::string valueToString(Value *V) {
        if (!V) return "<null>";
        std::string tmp;
        raw_string_ostream rso(tmp);
        V->print(rso);
        return rso.str();
    }

    void propagateComplexIV(Instruction *instr) {
        if (!isa<BinaryOperator>(instr)) return;

        Value *op0 = instr->getOperand(0);
        Value *op1 = instr->getOperand(1);

        IndVarInfo newIV;
        Value *iv = nullptr;
        int64_t constant = 0;

        if (indVarMap.count(op0) && isConstInt(op1)) {
            iv = op0;
            constant = getConstInt(op1);
        } else if (indVarMap.count(op1) && isConstInt(op0)) {
            iv = op1;
            constant = getConstInt(op0);
        } else return;

        IndVarInfo oldIV = indVarMap[iv];

        switch (instr->getOpcode()) {
            case Instruction::Add:
                newIV.base = oldIV.base;
                newIV.multiplicative = oldIV.multiplicative;
                newIV.additive = oldIV.additive + constant;
                newIV.step = oldIV.step;
                break;
            case Instruction::Sub:
                if (op0 == iv) {
                    newIV.base = oldIV.base;
                    newIV.multiplicative = oldIV.multiplicative;
                    newIV.additive = oldIV.additive - constant;
                    newIV.step = oldIV.step;
                } else if (op1 == iv) {
                    newIV.base = oldIV.base;
                    newIV.multiplicative = -oldIV.multiplicative;
                    newIV.additive = constant - oldIV.additive;
                    newIV.step = -oldIV.step;
                } else return;
                break;
            case Instruction::Mul:
                newIV.base = oldIV.base;
                newIV.multiplicative = oldIV.multiplicative * constant;
                newIV.additive = oldIV.additive * constant;
                newIV.step = oldIV.step * constant;
                break;
            default:
                return;
        }

        indVarMap[instr] = newIV;

        errs() << "Propagated complex IV: " << *instr
               << " (base: " << (newIV.base ? valueToString(newIV.base) : "<null>")
               << ", mul: " << newIV.multiplicative
               << ", add: " << newIV.additive
               << ", step: " << newIV.step << ")\n";
    }

    void replaceDependentInstructions(PHINode *oldPhi, PHINode *newPhi, Loop *loop) {
        SmallVector<Instruction*, 8> toReplace;
        for (auto *U : oldPhi->users()) {
            if (Instruction *user = dyn_cast<Instruction>(U)) {
                if (!loop->contains(user)) continue;
                if (user->getOpcode() == Instruction::Add ||
                    user->getOpcode() == Instruction::Sub ||
                    user->getOpcode() == Instruction::Mul)
                    toReplace.push_back(user);
            }
        }

        for (Instruction *inst : toReplace) {
            IRBuilder<> Builder(inst);
            Value *op0 = inst->getOperand(0) == oldPhi ? newPhi : inst->getOperand(0);
            Value *op1 = inst->getOperand(1) == oldPhi ? newPhi : inst->getOperand(1);
            Value *replacement = nullptr;

            switch(inst->getOpcode()) {
                case Instruction::Add: replacement = Builder.CreateAdd(op0, op1); break;
                case Instruction::Sub: replacement = Builder.CreateSub(op0, op1); break;
                case Instruction::Mul: replacement = Builder.CreateMul(op0, op1); break;
                default: break;
            }

            if (replacement) {
                inst->replaceAllUsesWith(replacement);
                inst->eraseFromParent();
                propagateComplexIV(cast<Instruction>(replacement));
            }
        }
    }

    void applyStrengthReduction(PHINode *phi, Loop *loop, ConstantInt *stepConst) {
        BasicBlock *header = loop->getHeader();
        BasicBlock *preheader = loop->getLoopPreheader();
        BasicBlock *latch = loop->getLoopLatch();
        if (!preheader || !latch) return;

        PHINode *newPhi = PHINode::Create(phi->getType(), 2, "", header->getFirstNonPHI());
        Value *initVal = (phi->getIncomingBlock(0) == preheader) ? phi->getIncomingValue(0)
                                                                 : phi->getIncomingValue(1);
        newPhi->addIncoming(initVal, preheader);

        int64_t baseStep = stepConst->getSExtValue();
        indVarMap[newPhi] = { initVal, 0, 1, baseStep };

        IRBuilder<> Builder(latch->getTerminator());
        Value *stepConstVal = ConstantInt::getSigned(newPhi->getType(), baseStep);
        Value *newAdd = Builder.CreateAdd(newPhi, stepConstVal);
        newPhi->addIncoming(newAdd, latch);

        replaceDependentInstructions(phi, newPhi, loop);
    }

    bool detectAndApplyIV(PHINode *phi, Loop *loop, std::set<PHINode*> &processed) {
        if (processed.count(phi)) return false;

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

        ConstantInt *rawConst = nullptr;
        bool phiIsOp0 = (binOp->getOperand(0) == phi);
        if (phiIsOp0 && isa<ConstantInt>(binOp->getOperand(1)))
            rawConst = cast<ConstantInt>(binOp->getOperand(1));
        else if (!phiIsOp0 && isa<ConstantInt>(binOp->getOperand(0)))
            rawConst = cast<ConstantInt>(binOp->getOperand(0));
        else
            return false;

        int64_t raw = rawConst->getSExtValue();
        int64_t signedStep = 0;
        switch (binOp->getOpcode()) {
            case Instruction::Add:
                signedStep = raw;
                break;
            case Instruction::Sub:
                signedStep = -raw; // phi - const OR const - phi => step je -raw
                break;
            case Instruction::Mul:
                return false;
            default:
                return false;
        }

        // kreiramo LLVM ConstantInt
        ConstantInt *stepConst = ConstantInt::get(
            phi->getContext(),
            APInt(phi->getType()->getIntegerBitWidth(), signedStep, true)
        );

        applyStrengthReduction(phi, loop, stepConst);


        errs() << "IV detected and strength reduction applied:\n"
               << "  PHI: " << *phi
               << "\n  init: " << (initVal ? valueToString(initVal) : "<null>")
               << ", step: " << signedStep << "\n";

        processed.insert(phi);
        return true;
    }

    void createOptimizedPHINodes(Loop *loop) {
        BasicBlock *header = loop->getHeader();
        BasicBlock *preheader = loop->getLoopPreheader();
        BasicBlock *latch = loop->getLoopLatch();
        if (!preheader || !latch) return;

        for (auto &[val, info] : indVarMap) {
            if (PHINode *phi = dyn_cast<PHINode>(val)) continue;

            IRBuilder<> Builder(header->getFirstNonPHI());
            PHINode *newPhi = Builder.CreatePHI(val->getType(), 2);

            Value *mul = Builder.CreateMul(
                info.base,
                ConstantInt::get(info.base->getType(), info.multiplicative)
            );
            Value *incomingPreheader = Builder.CreateAdd(
                mul,
                ConstantInt::getSigned(mul->getType(), info.additive)
            );
            newPhi->addIncoming(incomingPreheader, preheader);

            IRBuilder<> latchBuilder(latch->getTerminator());
            Value *stepConst = ConstantInt::getSigned(newPhi->getType(), info.step);
            Value *incomingLatch = latchBuilder.CreateAdd(newPhi, stepConst);
            newPhi->addIncoming(incomingLatch, latch);

            val->replaceAllUsesWith(newPhi);

            errs() << "Optimized PHI created for complex IV: " << *newPhi
                   << " (mul=" << info.multiplicative << ", add=" << info.additive
                   << ", step=" << info.step << ")\n";
        }
    }

    void processLoopRecursively(Loop *loop) {
        BasicBlock *header = loop->getHeader();
        std::set<PHINode*> processed;

        SmallVector<PHINode*, 8> originalPhis;
        for (auto &I : *header)
            if (PHINode *phi = dyn_cast<PHINode>(&I))
                originalPhis.push_back(phi);

        for (PHINode *phi : originalPhis)
            detectAndApplyIV(phi, loop, processed);

        createOptimizedPHINodes(loop);

        for (Loop *subLoop : loop->getSubLoops())
            processLoopRecursively(subLoop);
    }

public:
    bool runOnFunction(Function &F) override {
        LoopInfo &LI = getAnalysis<LoopInfoWrapperPass>().getLoopInfo();
        errs() << "Running IV strength reduction on function: " << F.getName() << "\n";

        for (Loop *loop : LI)
            processLoopRecursively(loop);

        return true;
    }
};

} // namespace

char IVStrengthReductionPass::ID = 0;
static RegisterPass<IVStrengthReductionPass> X(
    "our-ivsr-pass", "Strength reduction of induction variables (handles negative steps)");