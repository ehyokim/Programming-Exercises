#include <stdio.h>
#include <limits.h>
#include <float.h>

int main() 
{

    printf("Size, Min, Max of char in bytes: %lu, %d, %d \n", sizeof(char), CHAR_MIN, CHAR_MAX);
    printf("Size, Min, Max of unsigned char in bytes: %lu, %d, %u \n", sizeof(unsigned char), 0, UCHAR_MAX);
    printf("Size, Min, Max of signed int in bytes: %lu, %d, %d \n", sizeof(int), INT_MIN, INT_MAX);
    printf("Size, Min, Max of unsigned int in bytes: %lu, %d, %u \n", sizeof(unsigned int), 0, UINT_MAX);
    printf("Size, Min, Max of short int in bytes: %lu, %d, %d \n", sizeof(short), SHRT_MIN, SHRT_MAX);
    printf("Size, Min, Max of unsigned short int in bytes: %lu, %d, %d \n", sizeof(unsigned short), 0, USHRT_MAX);
    printf("Size, Min, Max of long int in bytes: %lu, %lu, %lu \n", sizeof(long), LONG_MIN, LONG_MAX);
    printf("Size, Min, Max of unsigned long int in bytes: %lu, %d, %lu \n", sizeof(unsigned long), 0, ULONG_MAX);
    printf("Size, Min, Max of long long in bytes: %lu, %lld, %lld \n", sizeof(long long), LLONG_MIN, LLONG_MAX);
    printf("Size, Min, Max of unsigned long long in bytes: %lu, %d, %llu \n", sizeof(unsigned long long), 0, ULLONG_MAX);

    printf("Size, Min, Max of float in bytes: %lu, %e, %e \n", sizeof(float), FLT_MIN, FLT_MAX);
    printf("Size, Min, Max of double in bytes: %lu, %e, %e \n", sizeof(double), DBL_MIN, DBL_MAX);
    printf("Size, Min, Max of long double in bytes: %lu, %Le, %Le \n", sizeof(long double), LDBL_MIN, LDBL_MAX);  
}