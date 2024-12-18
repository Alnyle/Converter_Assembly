#include <stdio.h>

int main() {
    // Write C code here
    char seven = 'F';
    int res;
    if (seven > '9') {
        res = seven - 55;
    } else {
        res = seven - '0';
    }

    printf("%d", res);

    return 0;
}
