#include <stdio.h>
#include <ctype.h>
#include <stdlib.h>
#include <string.h>
#include "include/ch.h"
#include "include/word.h"
#define MAXLEN 100

struct tnode {
    char *word;
    unsigned count;
    struct tnode *left;
    struct tnode *right;
};

struct tnode *addtree(struct tnode *p, char *word);
struct tnode *tralloc(void); 
void qSort(struct tnode *v[], int left, int right);
void populate_tnode_arr(struct tnode *p, struct tnode *v[]);
void swap(struct tnode *v[], int i, int j);

static unsigned num_unique_words = 0;

int main() 
{   
    struct tnode *root = NULL;
    char word[MAXLEN];
    char c;

    while ((c = getword(word, MAXLEN)) != EOF) {
        if (isalpha(c))
            root = addtree(root, word);
    }

    struct tnode *v[num_unique_words];
    populate_tnode_arr(root, v);
    qSort(v, 0, num_unique_words - 1);

    for(int i = 0; i < num_unique_words; i++)
        printf("Word: %s\n Frequency: %u\n\n", v[i]->word, v[i]->count);

}

struct tnode *addtree(struct tnode *p, char *word)
{
    int cond;
    if(p == NULL) {
        p = tralloc();
        p->word = strdup(word);
        p->left = p->right = NULL;
        p->count = 1;
        num_unique_words++;
    }
    else if ((cond = strcmp(word, p->word)) < 0)
        p->left = addtree(p->left, word);
    else if (cond > 0) 
        p->right = addtree(p->right, word);
    else {
        p->count++;
    }
    return p;
}

void populate_tnode_arr(struct tnode *p, struct tnode *v[])
{
    static unsigned curr_idx = 0;
    if (p != NULL) {
        v[curr_idx] = p;
        if(p->left != NULL) 
            curr_idx++;
        populate_tnode_arr(p->left, v);
        
        if(p->right != NULL) 
            curr_idx++;
        populate_tnode_arr(p->right, v);
    }
}

struct tnode *tralloc() 
{
    struct tnode *p = (struct tnode *) malloc(sizeof(struct tnode));
    if(p != NULL) 
        return p;
    else {
        printf("Could not allocate tree node");
        return NULL;
    }
}

void qSort(struct tnode *v[], int left, int right)
{
    int i, last;
    if (left >= right) /* do nothing if array contains */ 
        return; /* fewer than two elements */
    swap(v, left, (left + right)/2);
    last = left;

    for (i = left+1; i <= right; i++)
        if (v[i]->count < v[left]->count)
            swap(v, ++last, i);

    swap(v, left, last);
    qSort(v, left, last-1);
    qSort(v, last+1, right);
}

void swap(struct tnode *v[], int i, int j)
{
    struct tnode *temp = v[i];
    v[i] = v[j];
    v[j] = temp;
}