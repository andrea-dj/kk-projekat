#include <stdio.h>

int main() {
    int sum = 0;
    int base = 3;
    int scale = 2;

    for (int i = 0; i < 4; i++) {
        int inner_sum = 0;

        for (int j = 0; j < 6; j++) {
            int prod1 = j * 4;
            int prod2 = j * base;
            inner_sum += prod1 + prod2;
        }

        sum += inner_sum * scale;
    }

    printf("Final sum = %d\n", sum);
    return 0;
}
