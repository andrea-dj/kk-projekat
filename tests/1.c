#include <stdio.h>

int main() {
    int sum1 = 0, sum2 = 0, sum3 = 0;
    int x = 5;

    for (int i = 0; i < 10; i++) {
        int a = i * 4 + 2; 
        int b = i / 4;  
        sum1 += a + b;
    }


    for (int j = 20; j > 0; j -= 2) {
        int b = j - 3;       
        sum2 += b;
    }

    for (int m = 0; m < 5; m++) {
        for (int n = 0; n < 5; n++) {
            int t = m * 2 + n * 3 + 1; 
            sum3 += t;
        }
    }

    printf("Results: %d %d %d\n", sum1, sum2, sum3);
    return 0;
}

