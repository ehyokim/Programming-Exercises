#include <stdio.h>

int main(void)
{
    printf("Size of int in bytes: %lu \n", sizeof(int));
    printf("Size of float in bytes: %lu \n", sizeof(float));
    printf("Size of short int  in bytes: %lu \n", sizeof(short));
    printf("Size of long int in bytes: %lu \n", sizeof(long));
    printf("Value of EOF on my machine: %d \n", EOF);
    printf("Value of blank on my machine: %d \n", ' ');
    printf("Value of backslash on my machine: %d \n", '\\');

}