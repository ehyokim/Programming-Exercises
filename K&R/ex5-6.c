#include <stdio.h>

void reverse(char *s);

int main()
{
    char s[] = "abcdef";
    reverse(s);
    printf("Reversed string: %s\n", s);
}

//Recursive implementation of reverse this time with pointers. 
void reverse(char *s)
{
    char first_char = *s;
    if (first_char) {

        reverse(s+1);
        char *rev_suf = s+1;

        for (; (*s = *rev_suf) != '\0'; s++, rev_suf++);
        *s = first_char;
    }
}