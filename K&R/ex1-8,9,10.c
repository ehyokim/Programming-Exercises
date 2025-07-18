#include <stdio.h>

int ex1_8(void);
void ex1_9(void);
void ex1_10(void);


int main(void)
{
    //printf("Result of number of blanks, tabs, and newlines: %d \n", ex1_8());
    //printf("Result of removing all etraneous blank spacees: \n"); 
    //ex1_9();
    ex1_10();
}

int ex1_8() 
{
    int count = 0;
    char c;

    while ((c = getchar()) != EOF) {
        if((c == ' ') || (c == '\t') || (c == '\n'))
            count++;
    }

    return count;
}

void ex1_9() 
{
    char c;
    int is_blank = 0;

    while ((c = getchar()) != EOF) {

        if(!is_blank)
            putchar(c);

        if((is_blank == 0) && (c == ' ')) 
            is_blank = 1;
        
        if((is_blank == 1) && (c != ' ')){
            is_blank = 0;
            putchar(c);
        }

    }

}

void ex1_10()
{
    char c;
    while ((c = getchar()) != EOF) {
        if (c == '\t')
            printf("\\t");
        else if (c == '\b')
            printf("\\b");
        else if (c == '\\')
            printf("\\\\");
        else
            putchar(c);
    }
}
