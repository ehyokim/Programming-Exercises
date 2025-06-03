#include <stdio.h>

void squeeze(char s1[], char s2[]);

int main()
{
    char s1[] = "abbccd";
    char s2[] = "bcd";
    squeeze(s1,s2);

    printf("Removing abc from a: %s", s1);

}

void squeeze(char s1[], char s2[])
{
    int i, j, k;
    for (i = j = 0; s1[i] != '\0'; i++) {
        int remove = 0;
        for(k = 0; s2[k] != '\0'; k++) {
            if(s1[i] == s2[k])
                remove = 1;
        }
        if(!remove) {
            s1[j++] = s1[i];
        }
    }
    s1[j] = '\0';
}