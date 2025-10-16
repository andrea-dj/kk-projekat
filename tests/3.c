#include <stdio.h>

// Function outside main that takes multiple parameters
int sumAndDouble(int a, int b) {
    return (a + b) * 2; // linear combination of parameters
}

int main() {
    int n = 10;
    int total = 0;

    // 1. Linear increasing IV
    for (int i = 1; i <= n; i++) {
        total += i + 1; // linear IV, safe for pass
    }

    // 2. Negative step IV
    for (int j = 20; j > 0; j -= 3) {
        total += j * 2; // linear IV with negative step, safe
    }

    // 3. Linear loop using a function with multiple parameters
    for (int k = 5; k < 15; k += 2) {
        int m = k * 3;                // linear combination
        total += sumAndDouble(k, m);  // still linear from the pass perspective
    }

    // 4. Another linear loop with dependent expressions
    for (int x = 0; x < 20; x += 4) {
        int y = x + 1;  // linear
        int z = y * 2;  // linear combination
        total += z;
    }

    printf("Final total = %d\n", total);
    return 0;
}