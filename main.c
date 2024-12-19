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
        if (digit >= cur_sys) {
            return 0;
        }

    }
    return 1;
}

// OtherToDecimal: not finshed yet
int OtherToDecimal(char num[], int cur_sys, int size) {
    int res = 0;
    for (int i = 0; i < size; i++) {
        int digit;
        if (num[size - i - 1] >= '0' && num[size - i - 1] <= '9') {
            digit = num[size - i - 1] - '0';
        } else {
            digit = (num[size - i - 1] - 'A') + 10;
        }
        int x = pow(cur_sys, i);
        printf("digit = %d \n", digit);
        res = res + pow(cur_sys, i) * digit; 
    }
    printf("result = %d", res);
    return res;
}


int DecimalToOther(int num, int new_sys, int size) {

    
    return res;
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
            OtherToDecimal(num, cur_sys, size);
        }
    } else {
        printf("%s is not valid number", num);
    }

    return 0;
}
