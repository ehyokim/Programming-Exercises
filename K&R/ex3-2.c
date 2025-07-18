#include <stdio.h>
#define MAXLEN 100

void escape(char s[], char t[]);

int main()
{
    char s[MAXLEN];
    char t[] = "Lorem		ipsum 	dolor	sit	amet, consectetur	adipiscing	xelit";
    escape(s,t);
    printf("Revised string: %s \n", s);
}

void escape(char s[], char t[])
{
    int i, j;
    for(i = j = 0; j < MAXLEN-1 && t[i] != '\0'; i++, j++) {
        switch(t[i]) {
            case '\n':
                s[j] = '\\';
                if (j != MAXLEN - 2) {
                    s[j+1] = 'n';
                    j++;
                }
                break;
            case '\t':
                s[j] = '\\';
                if (j != MAXLEN - 2) {
                    s[j+1] = 't';
                    j++;
                }
                break;
            default:
                s[j] = t[i];
                break;
        }
    }
    s[j] = '\0';
}
