#include <stdio.h>
#include <string.h>

void reverse(char s[]);

int main() 
{
    char s[] = "hello";
    reverse(s);
    printf("Reversed string: %s", s);
}

void reverse(char s[]) 
{
    char first_char = s[0];

    if (first_char) {

        int s_len = strlen(s);
        char suffix[s_len];
    
    
        int i, k;
        for(k = 0, i = 1; i < s_len; i++, k++)
            suffix[k] = s[i];
        suffix[k] = '\0';
    
        reverse(suffix);
    
        int j;
        for(j = 0; j < s_len - 1; j++)
            s[j] = suffix[j];
    
        s[j] = first_char;
    }

}
    
