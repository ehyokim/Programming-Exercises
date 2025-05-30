#include <stdio.h>
#define MAXLINE 1000 /* maximum input line length */

void reverse(char s[], int len);
int getLine(char line[], int maxline);
void copy(char to[], char from[]);

int main() {

    int len;
    char curr_line[MAXLINE];

    while((len = getLine(curr_line, MAXLINE)) > 0) {
        reverse(curr_line, len);
        printf("%s", curr_line);
    }

}

void reverse(char s[], int len) 
{
    char temp;
    int tail_idx;
    
    int rev_len = (s[len-1] == '\n') ? len - 1 : len;

    for(int idx = 0; idx < (rev_len / 2) ; idx++) {
        temp = s[idx];
        tail_idx = rev_len - idx - 1;
        s[idx] = s[tail_idx];
        s[tail_idx] = temp;
    }
}

int getLine(char s[], int lim)
{
    /* current input line */
    int c, i;
    for (i = 0; i < lim - 1 && (c = getchar()) != EOF && c != '\n'; ++i) 
        s[i] = c;

    if (c == '\n') {
        s[i] = c;
        ++i;
    }

    s[i] = '\0';
    return i;
}