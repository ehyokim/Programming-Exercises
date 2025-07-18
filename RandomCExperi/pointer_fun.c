#include <stdio.h>

void unsigned_version();
void signed_version();

int main()
{   
    signed_version();
}

void signed_version()
{
    // Every character is initialized in little endian. If you initialize each character byte separately, be wary that the least significant bit is always first.
    unsigned char A[8];
    A[1] = A[2] = A[4] = A[5] =  A[6] =  A[7] = 0;
    A[0] = 1;
    A[3] = 1 << 7; //Although the character cells are initialized in little endian order, the shift operator is in respect to big endian order. 
    /* Note that this gives me -2147483647 since setting the most significant bit to 1 turns the integer negative and this binary number in two's complement is exactly -2147483647 (Flip all the digits and add one to see the positive magnitude)*/


    unsigned char *p = A;
    int *p1 = (int *) p;
    printf("First integer: %d \n", *p1);
    printf("Second integer: %d \n", *(p1+1));
}    

void unsigned_version()
{
    // Every character is initialized in little endian. If you initialize each character byte separately, be wary that the least significant bit is always first.
    unsigned char A[8];
    A[0] = A[2] =  A[3] =  A[5] =  A[6] =  A[7] = 0;
    A[1] = 1; //Second byte is 1, so that means that the eighth bit of the integer is 1. The integer is therefore 256.
    A[4] = 1; //First byte is 1, so that means that the first bit of the integer is 1. The integer is therefore 1.

    unsigned char *p = A;
    int *p1 = (int *) p;
    printf("First integer: %d \n", *p1);
    printf("Second integer: %d \n", *(p1+1));
}