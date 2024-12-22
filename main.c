#include <stdio.h>
#include <math.h>
#include <string.h>

int maxLength = 1000;

char indexes[] = {'0', '1', '2', '3', '4', '5', '6', '7', '8', '9', 'A', 'B', 'C', 'D', 'E', 'F'};
int size2 = sizeof(indexes) / sizeof(indexes[0]);

// OtherToDecimal
int validate_number(char num[], int cur_sys, int size) {


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
    // printf("result = %d", res);
    return res;
}

// convert from string to int
void strToInt(char n_str[], int size) {
    for (int i = 0; i < size; i++) {
        printf("%c", n_str[i]);
    }
}

// from decimal to other systems
void DecimalToOther(int num, int new_sys, int n_reminders) {

    char n_str[n_reminders];

    int res = 0;
    int i = n_reminders - 1;
      while (num != 0) {
        int remainder = num % new_sys;  // Ensure `remainder` is an integer
        if (remainder < 10) {
            n_str[i] = remainder + '0';  // For digits 0-9
        } else {
            n_str[i] = remainder - 10 + 'A';  // For letters A-Z
        }
        // printf("%c", n_str[i]);
        i--;
        num /= new_sys;
    }

    strToInt(n_str, n_reminders);
    // OtherToDecimal(n_str, n_reminders, n_reminders)
}

// count number of reminder for number "n"
int countreminders(int num, int new_sys) {
    int n_reminders = 0;
    while(num != 0) {
        num /= new_sys;
        n_reminders++;
    }
    return n_reminders;
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

    int size = strlen(num); 

    int isValid = validate_number(num, cur_sys, size);
    int final = 0;
    if (isValid) {
        printf("%s is valid number \n", num);
        final = OtherToDecimal(num, cur_sys, size);
        int n_reminders = countreminders(final, new_sys);
        printf("%d is reminders is number \n", n_reminders);
        DecimalToOther(final, new_sys, n_reminders);

    } else {
        printf("%s is not valid number", num);
    }

    return 0;
}
