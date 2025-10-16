#include <stdio.h>

int simple_ivsr(int n) {
    int sum = 0;
    for (int i = 0; i < n; i++) {
        int t = 3 * i + 5;  
        sum += t;
    }
    return sum;
}

int main() {
    printf("%d\n", simple_ivsr(5));
    return 0;
}
