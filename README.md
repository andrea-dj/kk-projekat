# IV Strength Reduction LLVM Pass

This project implements **Induction Variable (IV) Strength Reduction** for LLVM.  
Strength reduction is an optimization that simplifies expressions inside loops (e.g., converting `i * 4 + 2` into a simple increment).

An induction variable is a variable used in a loop (for, while, do-while loop). It controls the iteration of the loop.
Example:

```
for (int i = 0; i < 20; i++) //'i' is an induction variable
{
    cout << i;
}

```

The pass is implemented as a **LLVM FunctionPass** and detects both canonical and more complex induction variables, including negative steps.


**The following code shows an unoptimized loop:**

```
int i = 0;
while( i < 10 ) {
  int j = 3 * i + 2;
  a[j] = a[j] - 2;
  i = i + 2;
}
```

**Optimized code:**

```
int i = 0;
int j = 2; // j = 3 * 0 + 2
while( i < 10 ) {
  a[j] = a[j] - 2;
  i = i + 2;
  j = j + 6; // j = j + 3 * 2
}

```

## Instructions:

**To run it, follow these steps:**

 1. Place the make_llvm.sh script in the llvmproject/.
 2. Move IVStrengthReductionPass directory to llvmproject/llvm/lib/Transforms/.
 3. Add to the llvmproject/llvm/lib/Transforms/CMakeLists.txt the following line:

```
add_subdirectory(IVStrengthReductionPass)
```
**Running the tests:**

 1. Place the tests directory into the llvm_project/build directory
 2. Run the run_pass.sh script from the llvm_project/build/tests directory as follows: 
 ```
 ./run_pass.sh 1.c 
 ```
 3. If you're adding your own .c program, place it into the llvm_project/build/tests directory

## Literature:
 * [Shaojie Xiang & Yi-Hsiang Lai & Yuan Zhou: Strength Reduction Pass in LLVM](https://www.cs.cornell.edu/courses/cs6120/2019fa/blog/strength-reduction-pass-in-llvm/)

 * [Pingali strength reduction](https://www.cs.utexas.edu/%7Epingali/CS380C/2019/lectures/strengthReduction.pdf)

 * [GeeksForGeeks](https://www.geeksforgeeks.org/compiler-design/induction-variable-and-strength-reduction/)

