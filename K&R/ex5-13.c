#include <stdio.h>
#include <stdlib.h>
#include <ctype.h>
#define MAXLEN 1001

int getLine(char *buffer, int lim);


/*Accidently used a two-dim array here.*/
int main(int argc, char *argv[])
{
    int lines_to_print;
    if (argc > 1 && (*++argv)[0] == '-' && isdigit((*argv)[1])) {
        lines_to_print = atoi(*argv + 1);
    }
    else
        lines_to_print = 10;

    if(!lines_to_print)
        return 0;
    
    int num_of_lin_read = 0;
    char memory[lines_to_print * MAXLEN];
    char buffer[MAXLEN];
    int len, mem_offset;

    while ((len = getLine(buffer, MAXLEN)) >= 0) {
        mem_offset = (num_of_lin_read % lines_to_print) * MAXLEN;
        for (int i = 0; i < len + 1; i++)
            memory[mem_offset + i] = buffer[i];
        num_of_lin_read++;
    } 

    int starting_idx = num_of_lin_read % lines_to_print;
    for (int j = 0; j < lines_to_print; j++) {
        printf("%s\n", &memory[((starting_idx + j) % lines_to_print) * MAXLEN]);
    }


}

int getLine(char *buffer, int lim)
{
    int i;
    char c;
    for (i = 0; i < lim - 1 && (c = getchar()) != EOF && c != '\n'; i++)
        buffer[i] = c;

    if (i == lim - 1) // Just get to the next new line if the buffer is filled.
        while((c = getchar()) != '\n');
    else if (c == EOF)
        return -1;

    buffer[i] = '\0';
    return i;
}