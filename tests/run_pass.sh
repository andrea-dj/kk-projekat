#!/bin/bash

TEST=$1
BASENAME=$(basename "$TEST" .c)


../bin/clang -fno-discard-value-names -S -emit-llvm -O0 -Xclang -disable-O0-optnone \
    "$TEST" -o "$BASENAME.ll"

../bin/opt -S -enable-new-pm=0 -mem2reg "$BASENAME.ll" -o "${BASENAME}_simpl.ll"

../bin/opt -S -enable-new-pm=0 -load ../lib/LLVMIVStrengthReductionPass.so \
    -our-ivsr-pass "${BASENAME}_simpl.ll" -o "${BASENAME}_new.ll"

../bin/clang ${BASENAME}_new.ll -o clang_out
CLANG_RESULT=$(./clang_out)

GCC_RESULT=$(gcc "$TEST" -o gcc_out && ./gcc_out)

echo ""
echo "=== Comparing results ==="
echo "gcc => $GCC_RESULT"
echo "clang => $CLANG_RESULT"

if [ "$GCC_RESULT" == "$CLANG_RESULT" ]; then
    echo "Results identical!"
else
    echo "ERROR: Results differ!"
fi

rm -f clang_out gcc_out
