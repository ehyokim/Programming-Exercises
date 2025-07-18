#include <stdio.h>
#include <stdlib.h>  /* for  atof() */
#include <ctype.h>

#define MAXOP 100 /* max size of operand or operator */ 
#define NUMBER '0' /* signal that a number was found */
#define BUFSIZE 100
#define MAXVAL 100 /* maximum depth of val stack */

int getop(char []);
void push(double);
double pop(void);
int getch(void);
void ungetch(int);
void print_top(void);
void duplicate_top(void);
void swap_top(void);
void clear_stack(void);
void ungets(char s[]);


   /* reverse Polish calculator */
int main()
{
       int type;
       double op2;
       char s[MAXOP];

       while ((type = getop(s)) != EOF) {
           switch (type) {
            case NUMBER:
                push(atof(s));
                break;
            case '+':
                push(pop() + pop());
                break;
            case '*':
                push(pop() * pop());
                break;
            case '-':
                op2 = pop();
                push(pop() - op2);
                break;
            case '/':
                op2 = pop();
                if (op2 != 0.0)
                    push(pop() / op2);
                else
                    printf("error: zero divisor\n");
                break;
            case '%':
                op2 = pop();
                if (op2 > 0.0)
                    push(pop() / op2);
                else 
                    printf("error: non-positive modulus\n");
                break;
            case 'p':
                print_top();
                break;
            case 'd':
                duplicate_top();
                break;
            case 's':
                swap_top();
                break;
            case 'c':
                clear_stack();
                break;
            case '\n':
                printf("\t%.8g\n", pop());
                break;
            default:
                printf("error: unknown command %s\n", s); 
                break;
        }
    }
    return 0;
}

int sp = 0;          /* next free stack position */
double val[MAXVAL];  /* value stack */

void print_top()
{
    if (sp > 0)
        printf("%f\n", val[sp - 1]);
    else
        printf("Stack is empty\n");
}

void duplicate_top()
{
    if (sp > 0 && sp < MAXVAL) {
        val[sp] = val[sp - 1];
        sp++;
    }
    else if (sp == MAXVAL)
        printf("Stack is full. Cannot duplicate. \n");
    else
        printf("Stack is empty. Nothing to duplicate.\n");
}

void swap_top()
{
    float temp;
    if (sp > 1) {
        temp = val[sp - 2];
        val[sp - 2] = val[sp - 1];
        val[sp - 1] = temp;
    }
    else 
        printf("Not enough elements in stack to swap \n");
}

void clear_stack()
{
    sp = 0;
}

/* push:  push f onto value stack */
void push(double f)
{
    if (sp < MAXVAL)
        val[sp++] = f;
    else
        printf("error: stack full, can't push %g\n", f);
}

/* pop:  pop and return top value from stack */
double pop(void)
{
    if (sp > 0)
        return val[--sp];
    else {
        printf("error: stack empty\n");
        return 0.0;
    }
}
/* getop: get next character or numeric operand */
int getop(char s[])
{
    int i, c;

    while ((s[0] = c = getch()) == ' ' || c == '\t')
        ;
 
    s[1] = '\0';

    if (!isdigit(c) && c != '.' && c != '-')
        return c;      /* not a number */


    i = 0;
    if (isdigit(c) || c == '-')    /* collect integer part */
        while (isdigit(s[++i] = c = getch()))
           ;

    if (c == '.')      /* collect fraction part */
        while (isdigit(s[++i] = c = getch()))
            ;

    s[i] = '\0';
    if (c != EOF)
        ungetch(c);

return NUMBER;
}   

char buf[BUFSIZE]; /* buffer for ungetch */
int bufp = 0; /* next free position in buf */

int getch(void) /* get a (possibly pushed-back) character */ {
    return (bufp > 0) ? buf[--bufp] : getchar();
}

void ungetch(int c)   /* push character back on input */
{
    if (bufp >= BUFSIZE)
        printf("ungetch: too many characters\n");
    else
        buf[bufp++] = c;
}

void ungets(char s[]) {
    //Reverse the string first.
    int str_len;
    for(str_len = 0; s[str_len] != '\0'; str_len++);

    // This does not take into account the remaining space in the buffer and the resulting error statements that may be printed. 
    for(int k = str_len - 1;  k > 0; k--) 
        ungetch(s[k]);
}