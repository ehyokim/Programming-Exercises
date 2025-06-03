#include <stdio.h>
#define MAXLEN 100

void strCat(char *s, char *t);

int main()
{
    char s[MAXLEN] = "abc";
    char t[] = "efg";
    strCat(s,t);
    printf("Concatenated string %s\n", s);
}

/* Assumes that s has enough storage to concat t.*/
void strCat(char *s, char *t)
{
    while(*s != '\0')
        s++;
    while(*s++ = *t++);
}