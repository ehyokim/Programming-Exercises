#include <stdio.h>


int binsearch(int x, int v[], int n);

int main(void) 
{
    int A[6] = {0,1,2,3,4};
    printf("Result: %i", binsearch(4,A,6));
}


int binsearch(int x, int v[], int n)
{
    int low, mid, high;

    low = 0;
    high = n-1;
    while(low <= high) {
        mid = (low + high)/2;
    
        if (x < v[mid])
            high = mid;
        else if (x > v[mid])
            low = mid + 1;
        else
            return mid;

    }

    return -1;
}