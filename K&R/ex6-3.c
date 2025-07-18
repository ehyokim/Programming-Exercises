#include <stdio.h>
#include <ctype.h>
#include <stdlib.h>
#include <string.h>
#include "include/ch.h"
#define MAXLEN 100

struct linenum {
    struct linenum *next;
    unsigned linenum;
};

struct tnode {
    char *word;
    struct linenum *linenums;
    struct tnode *left;
    struct tnode *right;
};

struct tnode *addtree(struct tnode *p, char *word, unsigned linenum);
void printtree(struct tnode *p);
struct tnode *tralloc(void); 
struct linenum *lnalloc(void);
int getword(char *word, int lim);

int main() 
{   
    unsigned linenum = 1;
    struct tnode *root = NULL;
    char word[MAXLEN];
    char c;

    while ((c = getword(word, MAXLEN)) != EOF) {
        if (isalpha(c))
            root = addtree(root, word, linenum);
        else if (c == '\n')
            linenum++;
    }

    printtree(root);
}

struct tnode *addtree(struct tnode *p, char *word, unsigned linenum)
{
    int cond;
    if(p == NULL) {
        p = tralloc();
        p->word = strdup(word);
        p->left = p->right = NULL;
        p->linenums = lnalloc();
        (p->linenums)->next = NULL;
        (p->linenums)->linenum = linenum;

    }
    else if ((cond = strcmp(word, p->word)) < 0)
        p->left = addtree(p->left, word, linenum);
    else if (cond > 0) 
        p->right = addtree(p->right, word, linenum);
    else {
        struct linenum *curr_ln = p->linenums;
        while (curr_ln->next != NULL)
            curr_ln = curr_ln->next;
        curr_ln->next = lnalloc();
        (curr_ln->next)->next = NULL;
        (curr_ln->next)->linenum = linenum;
    }

    return p;
}

void printtree(struct tnode *p)
{
    if (p != NULL) {
        printtree(p->left);

        printf("Word: %s Line Nums: ", p->word);
    
        struct linenum *curr_ln = p->linenums;
        while (curr_ln != NULL) { 
            printf("%d ", curr_ln->linenum);
            curr_ln = curr_ln->next;
        }
        printf("\n");
        printtree(p->right);
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

struct linenum *lnalloc() 
{
    struct linenum *p = (struct linenum *) malloc(sizeof(struct linenum));
    if (p != NULL) 
        return p;
    else {
        printf("Could not allocate list num node");
        return NULL;
    }
}

int getword(char *word, int lim)
{
    int c;
    char *w = word;

    while (isspace(c = getch()) && c != '\n');
    if (c != EOF)
        *w++ = c;
    if (!isalpha(c)) {
        *w = '\0';
        return c;
    }
    for ( ; --lim > 0; w++)
        if (!isalnum(*w = getch())) {
            ungetch(*w);
        break;
        }
    *w = '\0';
    return word[0];
}