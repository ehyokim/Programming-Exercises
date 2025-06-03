#include <stdio.h>
#define MAXLEN 1000

void expand(char s[], char t[]); 
int islowerCase(char l, char h);
int isupperCase(char l, char h); 
int isDigit(char l, char h); 

int main() 
{
    char s[MAXLEN];
    char test1[] = "-";
    char test2[] = "a-";
    char test3[] = "a-b";
    char test4[] = "a-z";
    char test5[] = "1-5";
    char test6[] = "a-kL-Tz-z";
    expand(s, test6);

    printf("Expanded string: %s \n", s);
    
}

void expand(char s[], char t[]) 
{
    int i,j;
    for(i = j = 0; j < MAXLEN - 1 && t[i] != '\0'; i++) {
        if(t[i] == '-' && i > 0) {
            int gap;
            int expand = 0;
            int offset;
            if (expand = (islowerCase(t[i-1],t[i+1]) || isupperCase(t[i-1],t[i+1]) || isDigit(t[i-1],t[i+1]))) {                
                gap = t[i+1] - t[i-1] + 1;
                offset = t[i-1];
            }
            if (expand) {
                s[j] = s[j+1] = '\0'; //Re-align the index in s to prepare to expand the range.
                j--, i++; //Re-align the index to the end of the range in t.

                int k = 0;
                while (k < gap && j < MAXLEN - 1) {
                    s[j] = offset + k;
                    k++, j++;
                }

                
            }
            else
                s[j++] = t[i];
        }
        else
            s[j++] = t[i];
    }
    s[j] = '\0';
} 

int islowerCase(char l, char h) 
{
    return (l >= 'a' && l <= 'z') && (h >= 'a' && h <= 'z') && (l <= h);
}

int isupperCase(char l, char h) 
{
    return (l >= 'A' && l <= 'Z') && (h >= 'A' && h <= 'Z') && (l <= h);
}

int isDigit(char l, char h) 
{
    return (l >= '0' && l <= '9') && (h >= '0' && h <= '9') && (l <= h);    
}



