#include <stdio.h>

int strindex(char s[],char t[]);

int main() 
{
    char s[] = "hello";
    char t[] = "o";
    printf("Rightmost string index: %d \n", strindex(s,t));

}

int strindex(char s[],char t[])
{   
    int found_idx = -1;
    for(int i = 0; s[i] != '\0'; i++) {
        int k,j;
        for(j = i, k = 0; t[k] != '\0' && s[j] == t[k]; j++, k++)
            ;
        if (k > 0 && t[k] == '\0')
            found_idx = i;
    }
    return found_idx;
}