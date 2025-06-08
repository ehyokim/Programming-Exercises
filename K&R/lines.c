#include <stdio.h>
#include <string.h>
#include "include/lines.h"

#define MAXLEN 1000 /* max length of any input line */
#define ALLOCSIZE 10000 /* size of available space */

int getLine(char *, int);
char *alloc(int);
void afree(char *p);

static char allocbuf[ALLOCSIZE]; /* storage for alloc */ 
static char *allocp = allocbuf; /* next free position */


/* readlines: read input lines */
int readlines(char *lineptr[], int maxlines) 
{
    int len, nlines;
    char *p, line[MAXLEN];
    nlines = 0;

    while ((len = getLine(line, MAXLEN)) > 0)
        if (nlines >= maxlines || (p = alloc(len)) == NULL)
            return -1;
    else {
        line[len-1] = '\0';  /* delete newline */
        strcpy(p, line);
        lineptr[nlines++] = p;
    }
    return nlines;
}

/* writelines: write output lines */
void writelines(char *lineptr[], int nlines) {
    int i;
    for (i = 0; i < nlines; i++)
        printf("%d: %s\n\n", i+1, lineptr[i]);
}

char *alloc(int n) /* return pointer to n characters */ {
    if (allocbuf + ALLOCSIZE - allocp >= n) { /* it fits */ allocp += n;
        return allocp - n; /* old p */
    } else      /* not enough room */
        return 0;
}

void afree(char *p) /* free storage pointed to by p */ {
    if (p >= allocbuf && p < allocbuf + ALLOCSIZE)
        allocp = p;
}

int getLine(char s[], int lim)
{
    int c, i;
    i = 0;

    while (--lim > 0 && (c=getchar()) != EOF && c != '\n')
        s[i++] = c;
    if (c == '\n')
        s[i++] = c;

    s[i] = '\0';
    return i;
}

