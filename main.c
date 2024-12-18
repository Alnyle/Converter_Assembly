#include <stdio.h>
#include <math.h>
#include <string.h>

int maxLength = 1000;

char indexes[] = {'0', '1', '2', '3', '4', '5', '6', '7', '8', '9', 'A', 'B', 'C', 'D', 'E', 'F'};
int size2 = sizeof(indexes) / sizeof(indexes[0]);

// OtherToDecimal
int valid_number(char num[], int cur_sys, int size) {


    for (int i = 0; i < size; i++) {
        int digit;
        if (num[i] >= '0' && num[i] <= '9') {
            digit = num[i] - '0';
        } else {
            digit = (num[i] - 'A') + 10;
        }
        printf("%d \n", digit);
        if (digit >= cur_sys) {
            return 0;
        }

    }
    return 1;
}

// OtherToDecimal
void OtherToDecimal(char num[], int new_sys, int size) {
    int res = 0;
    for (int i = size - 1; i > -1; i--) {
        int digit = 0;
        if (num[i] > '9') {
            digit = num[i] - 55;
        } else {
            digit = num[i] - '0';
        }
        res = res * new_sys + digit; // Corrected to use new_sys
    }
    printf("result = %d", res);
}

int main() {
    char num[maxLength];
    int new_sys, cur_sys;

    // Read the number
    printf("Enter the current system: ");
    scanf("%d", &cur_sys);
    getchar(); // To clear the newline character left by scanf

    printf("Enter the number: ");
    scanf("%s", num); // Use %s to read the whole string

    printf("Enter the new system: ");
    scanf("%d", &new_sys);

    int size = strlen(num); // Now strlen(num) works correctly

    int isValid = valid_number(num, cur_sys, size);
    if (isValid) {
        printf("%s is valid number \n", num);
        if (cur_sys != 10) {
            OtherToDecimal(num, new_sys, size);
        }
    } else {
        printf("%s is not valid number", num);
    }

    return 0;
}
