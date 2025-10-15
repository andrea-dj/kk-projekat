#include "llvm/Pass.h"
#include "llvm/IR/Function.h"
#include "llvm/Support/raw_ostream.h"
#include "llvm/IR/Instructions.h"
#include "llvm/IR/IRBuilder.h"
#include "llvm/Analysis/LoopInfo.h"

using namespace llvm;

namespace {
struct IVStrengthReductionPass : public FunctionPass {
    static char ID;
    IVStrengthReductionPass() : FunctionPass(ID) {}
    
    void getAnalysisUsage(AnalysisUsage &AU) const override {
        AU.addRequired<LoopInfoWrapperPass>();
        FunctionPass::getAnalysisUsage(AU);
    }


    bool runOnFunction(Function &F) override {
        LoopInfo &loopInfo = getAnalysis<LoopInfoWrapperPass>().getLoopInfo();
        errs() << "Running on function: " << F.getName() << "\n";
        for (auto *loop : loopInfo) {
            BasicBlock *header = loop->getHeader();

            errs() << "Loop header: " << header->getName() << "\n";
            BasicBlock *preheader = loop->getLoopPreheader();
            errs() << "Loop header: " << (header->hasName() ? header->getName() : "<unnamed>") << "\n";
            if (preheader) {
                errs() << "Loop preheader: " << (preheader->hasName() ? preheader->getName() : "<unnamed>") << "\n";
            } else {
                errs() << "No loop preheader found\n";
            }
            errs().flush();

            // for (auto &I : *header) {
            //     if (auto *phi = dyn_cast<PHINode>(&I)) {
            //         errs() << "PHI node: " << I << "\n";
            //         for (unsigned idx = 0; idx < phi->getNumIncomingValues(); ++idx) {
            //             Value *incoming = phi->getIncomingValue(idx);
            //             BasicBlock *from = phi->getIncomingBlock(idx);
            //             errs() << "  Incoming value: " << *incoming
            //                 << " from block: " << (from->hasName() ? from->getName() : "<unnamed>") << "\n";
            //         }

            //     }
            // }

            for (auto &I : *header) {
                if (auto *phi = dyn_cast<PHINode>(&I)) {
                    Value *indVar = &I;
                    for (auto *BB : loop->getBlocks()) {
                        errs() << "Instructions in block: " << (BB->hasName() ? BB->getName() : "<unnamed>") << "\n";

                        for (auto &Instr : *BB) {
                            errs() << Instr << "\n";
                            if (auto *binOp = dyn_cast<BinaryOperator>(&Instr)) {
                                // Proveri da li je ovo add instrukcija koja koristi indVar
                                if (binOp->getOpcode() == Instruction::Add &&
                                    (binOp->getOperand(0) == indVar || binOp->getOperand(1) == indVar)) {
                                    // Pronađena inkrementacija
                                    errs() << "Found induction increment: " << Instr << "\n";
                                }

                                
                            }
                        }
                    }
                }
            }

        }

        return true;
    }
};

}

char IVStrengthReductionPass::ID = 0;
static RegisterPass<IVStrengthReductionPass> X("our-ivsr-pass", "Strength reduction of induction variables");