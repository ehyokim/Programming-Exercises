#include <stdio.h>

int htoi(char s[]);

int main() {

    printf("Converting 0x2: %d\n", htoi("0x2"));
    printf("Converting 0x12: %d\n", htoi("0x12"));
    printf("Converting 0XA2: %d\n", htoi("0XA2"));
    printf("Converting F: %d\n", htoi("F"));
    printf("Converting 0xFFFF: %d\n", htoi("0XFFFF"));
}

int htoi(char s[]) {

    int i = (s[0] == '0' && (s[1] == 'x' || s[1] == 'X')) ? 2 : 0;
    int digit;
    int n = 0;

    while ((digit = s[i]) != '\0') {
        if (digit >= '0' && digit <= '9') {
            n = 16 * n + (digit - '0');
        }
        else if (digit >= 'a' && digit <= 'f') {
            n = 16 * n + (digit - 'a' + 10);
        }
        else if (digit >= 'A' && digit <= 'F') {
            n = 16 * n + (digit - 'A' + 10);
        }
        else
            return -1;
            
        i++;
    }
    
    return n;
}