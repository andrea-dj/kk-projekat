add_llvm_library(LLVMIVStrengthReductionPass MODULE
  IVStrengthReductionPass.cpp

  PLUGIN_TOOL
    opt

  DEPENDS
    intrinsics_gen

)