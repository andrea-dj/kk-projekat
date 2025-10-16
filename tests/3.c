#include <stdio.h>

int array_ivsr(int n) {
    int arr[100];
    int sum = 0;

    for (int i = 0; i < n; i++) {
        arr[i] = i * 4 + 2;   
        sum += arr[i];
    }

    return sum;
}

int main() {
    printf("%d\n", array_ivsr(5));
    return 0;
}
