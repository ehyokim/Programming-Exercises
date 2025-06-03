#include <stdio.h>

int strend(char *s, char *t);

int main()
{
    char s[] = "Hello";
    char t[] = "z";
    printf("Found t at end of s: %d\n", strend(s,t));
}

//Doesn't check several edge cases. e.g where strlen(t) > strlen(s)
int strend(char *s, char *t) 
{
    int t_len;
    for (t_len = 0; *t != '\0'; t++, t_len++);
    for ( ; *s != '\0'; s++);

    s -= t_len;
    t -= t_len;
    while (*t != '\0' && *s == *t) {
        s++, t++;
    }

    return (*t == '\0');

        
}