#include <stdio.h>
#define MAXLINE 1000 /* maximum input line length */

int getLine(char line[], int maxline);
void copy(char to[], char from[]);


/* print the longest input line */
main()
{
    int len;
    int max;
    char line[MAXLINE];
    char longest[MAXLINE]; /* longest line saved here */
    
    max = 0;
    while ((len = getLine(line, MAXLINE)) > 0)
        if (len > max) {
            max = len;  
            copy(longest, line);
    }

    if (max > 0) /*there was a line*/
        printf("%s \n", longest);
        printf("Length of longest input line: %d", max);
    return 0;
}

/* current line length */
/* maximum length seen so far */
/* getline:  read a line into s, return length  */
int getLine(char s[], int lim)
{
    int c; 
    int i = 0;
    
    while ((c = getchar()) != EOF && c != '\n') {
        if (i < lim - 1)
            s[i] = c;
        else if (i == lim - 1) {
            s[i] = '\0';
        }
        i++;
    }  

    if (c == '\n') {
        if (i < lim - 1) {
            s[i] = c;
            s[++i] = '\0';
        } 
        else if (i == lim - 1) {
            s[i] = '\0';
        }
    }

    return i;
}
/* current input line */

/* copy: copy 'from' into 'to'; assume to is big enough */ 
void copy(char to[], char from[])
{
    int i;
    i = 0;

    while ((to[i] = from[i]) != '\0')
        ++i;
}