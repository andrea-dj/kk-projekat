add_llvm_library( LLVMStrengthRedPass MODULE
    StrengthReductionPass.cpp

    PLUGIN_TOOL
    opt
)