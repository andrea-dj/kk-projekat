#include "llvm/IR/Function.h"
#include "llvm/Pass.h"
#include "llvm/Support/raw_ostream.h"

using namespace llvm;

namespace {
struct OurPass : public FunctionPass {
  static char ID;
  OurPass() : FunctionPass(ID) {}

  bool runOnFunction(Function &F) override {
    errs() << "Hello from " << F.getName() << "\n";
    return false;
  }
};
}

char OurPass::ID = 0;
static RegisterPass<OurPass> X("our-pass", "This is a simple pass that does nothing!");