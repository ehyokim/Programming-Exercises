#include <stdio.h>


int binsearch(int x, int v[], int n);

int main(void) 
{
    int A[6] = {0,1,2,3,4};
    printf("Result: %i", binsearch(3,A,6));
}


int binsearch(int x, int v[], int n)
{
    int low, mid, high;

    low = 0;
    high = n-1;
    while(low <= high && v[mid] != x) {
        mid = (low + high)/2;
    
        if (x < v[mid])
            high = mid;
        else
            low = mid + 1;
    }

    return (low > high) ? -1 : mid;
}