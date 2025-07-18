#include <stdio.h>
#include <string.h>
#include <stdlib.h>
#include <ctype.h>
#include "include/lines.h"

#define MAXLINES 5000 /* max #lines to be sorted */ 

void qSort(void *lineptr[], int left, int right, int (*comp)(void *, void *, int), int (*order)(int), int dirord); //What a nigthmare. 
int numcmp(char *, char *, int dirord);
int foldstrcmp(char *, char *, int dirord);
int strCmp(char *s1, char *s2, int dirord);
int directorder(char s1, char s2); 
void swap(void *v[], int, int);
int incorder(int);
int decorder(int);

char *lineptr[MAXLINES]; /* pointers to text lines */

/* sort input lines */
int main(int argc, char *argv[])
{
    int nlines;        /* number of input lines read */
    int numeric = 0;   /* 1 if numeric sort */
    int reverse = 0; /* 1 if reverse sort */
    int fold = 0;
    int dirord = 0;

    if (argc > 1) {
        int arg_idx = argc - 1;
        while (arg_idx > 0) {
            if (strcmp(argv[arg_idx], "-n") == 0)
                numeric = 1;
            else if (strcmp(argv[arg_idx], "-r") == 0)
                reverse = 1; 
            else if (strcmp(argv[arg_idx], "-f") == 0)
                fold = 1;
            else if (strcmp(argv[arg_idx], "-d") == 0) 
                dirord = 1;

            arg_idx--;
        }
    }
        
    if ((nlines = readlines(lineptr, MAXLINES)) >= 0) {
        
        int (*strcompfunc)(char *, char *, int);
        strcompfunc = fold ? foldstrcmp : strcmp;

        qSort((void**) lineptr, 0, nlines-1,
            (int (*)(void*,void*, int))(numeric ? numcmp : strcompfunc),
            (int (*)(int))(reverse ? decorder: incorder),
            dirord); 
        writelines(lineptr, nlines);
        return 0;
    } else {
        printf("input too big to sort\n");
        return 1;
    }
}

void qSort(void *v[], int left, int right, int (*comp)(void *, void*, int), int (*order)(int), int dirord)
{
    int i, last;

    if(left >= right)
        return;

    swap(v, left, (left + right) / 2);
    last = left;
    for(i = left + 1; i <= right; i++) {
        if (order(comp(v[i], v[left], dirord))) 
            swap(v, ++last, i);
    }
    swap(v, left, last);
    qSort(v, left, last - 1, comp, order, dirord);
    qSort(v, last+1, right, comp, order, dirord);
}

void swap(void *v[], int i, int j)
{
    void *temp;
    
    temp = v[i];
    v[i] = v[j];
    v[j] = temp;
}


/* numcmp:  compare s1 and s2 numerically */
int numcmp(char *s1, char *s2, int dirord)
{
    double v1, v2;
    v1 = atof(s1);
    v2 = atof(s2);
    if (v1 < v2)
        return -1;
    else if (v1 > v2)
        return 1;
    else
        return 0;
}

int strCmp(char *s1, char *s2, int dirord) {
    for (;*s1 != '\0' && *s2 != '\0'; s1++,s2++) {
        if (dirord && !directorder(*s1, *s2))
            continue;        
        if (*s1 == *s2)
            continue;
        return (*s1 < *s2) ? -1 : 1;
    }
    if(!*s1)
        return 0;
    else
        (*s1 < *s2) ? -1 : 1;
}

int foldstrcmp(char *s1, char *s2, int dirord) 
{
    char s1_char, s2_char;
    while ((s1_char = *s1) != '\0' && (s2_char = *s2) != '\0') {

        if (dirord && !directorder(s1_char, s2_char))
            continue;

        if (isalpha(s1_char) && isalpha(s2_char)) 
            if (!(islower(s1_char) && islower(s2_char)) && !(isupper(s1_char) && isupper(s2_char)))
                s1_char = islower(s1_char) ? toupper(s1_char) : tolower(s1_char);
        
        if (s1_char != s2_char)
            return (s1_char < s2_char) ? -1 : 1;

        s1++, s2++;
    }

    if (*s1 == *s2) // Both strings are exactly equal
        return 0;
    else
        return (*s1 < *s2) ? -1 : 1; 

}

int directorder(char s1, char s2) 
{
    return (isalnum(s1) || isblank(s1)) && (isalnum(s2) || isblank(s2));
}

int incorder(int res)
{
    return res < 0;
}

int decorder(int res)
{
    return res > 0;
}