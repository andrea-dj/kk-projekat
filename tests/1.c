#include <stdio.h>

int main() {
    int sum1 = 0, sum2 = 0, sum3 = 0, sum4 = 0;
    int x = 5;

    // Basic induction variable + simple multiplicative dependency
    for (int i = 0; i < 10; i++) {
        int a = i * 4 + 2;   
        sum1 += a;
    }

    // Subtraction and decrement loop
    for (int j = 20; j > 0; j -= 2) {
        int b = j - 3;       // simple subtraction
        sum2 += b;
    }

    // Nested loop with a combination of multiple induction variables
    for (int m = 0; m < 5; m++) {
        for (int n = 0; n < 5; n++) {
            int t = m * 2 + n * 3 + 1; 
            sum3 += t;
        }
    }

    printf("Results: %d %d %d %d\n", sum1, sum2, sum3, sum4);
    return 0;
}

