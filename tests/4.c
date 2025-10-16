#include <stdio.h>

int div_in_loop(int n) {
    int sum = 0;
    for (int i = 2; i <= n; i+=2) {
        int t = i / 4;   
        sum += t;
    }
    return sum;
}

int main() {
    printf("%d\n", div_in_loop(16));
    return 0;
}
