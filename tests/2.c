#include <stdio.h>

int main() {
    int n = 10;
    int sum = 0;

    // Linear IV (induction variable)
    for (int i = 1; i <= n; i++) {
        sum += i;
    }

    // Compound IV: linear combination
    for (int j = 0; j < n; j++) {
        int k = 2 * j + 1;      // k is a compound induction variable
        sum += k;
    }

    // Combination of compound IVs
    for (int a = 1; a <= n; a++) {
        int b = 3 * a + 2;      // b is a compound IV
        int c = b * 2 + a;      // c depends on a compound IV
        sum += c;
    }

    printf("sum = %d\n", sum);
    return 0;
}

