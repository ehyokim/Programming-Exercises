   #include <stdio.h>
   
   #define IN   1  /* inside a word */
   #define OUT  0  /* outside a word */

   int main() {

        int state = OUT;
        char c;

        while ((c = getchar()) != EOF) {
            
            if(c == ' ' || c == '\t' || c == '\n') {
                if(state == IN)
                    putchar('\n');
                state = OUT;
            }
            else if (state == OUT) {
                state = IN;
                putchar(c);
            }
            else
                putchar(c);

        }
   }


