#include <stdio.h>

unsigned setbits(unsigned x, int p, int n, unsigned y);
unsigned invert(unsigned x, int p, int n);
unsigned rightrot(unsigned x, int n);

int main()
{


}

unsigned setbits(unsigned x, int p, int n, unsigned y) 
{
    unsigned x_mask = x & ((~0 << (p + 1)) | ~(~0 << (p + 1 - n)));
    return  x_mask | (~(~0 << n) & y) << (p + 1 - n);
}

unsigned invert(unsigned x, int p, int n) 
{
    return x ^ (~(~0 << n) << (p + 1 - n));
}

unsigned rightrot(unsigned x, int n) 
{
    unsigned n_right_bits = x & ~(~0 << n);
    unsigned rotated_x = x >> n;
    return (n_right_bits << (sizeof(unsigned) - n)) | rotated_x;
}