   #include <stdio.h>


   void print_histogram_hori(int freq[]);
   void print_histogram_vert(int freq[]);


   /*Prints histogram of the frequencies of lowercase characters in its input */
   int main() {

        char c;
        int freq[26];

        for(int i = 0; i < 26; i++) {
            freq[i] = 0;
        }

        while ((c = getchar()) != EOF) {
            if (c >= 'a' && c <= 'z')
                freq[c-'a']++;
        }

        /*print histogram horizontally*/
        //print_histogram_hori(freq);
        /*print histogram vertically*/
        print_histogram_vert(freq);

   }

   void print_histogram_hori(int freq[])
   {
        char curr_char;
        for (int i = 0; i < 26; i++) {
            curr_char = i + 'a';
            printf("%c: ", curr_char);
            for(int j = 0; j < freq[i]; j++)
                putchar('#');
            putchar('\n');
        }
   }

   void print_histogram_vert(int freq [])
   {
        int max_freq = 0;

        for (int i = 0; i < 26; i++) {
            if (freq[i] > max_freq)
                max_freq = freq[i];
        }

        for(int row = max_freq; row > 0; row--) {
            for(int col = 0; col < 26; col++) {
                if(freq[col] >= row)
                    putchar('#');
                else
                    putchar(' ');
            }
            putchar('\n');
        }
        
        for( int bottom = 0; bottom < 26; bottom++) {
            putchar(bottom + 'a');
        }
   }