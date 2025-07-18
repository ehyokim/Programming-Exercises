#include <stdio.h>
#include <string.h>
#include <stdlib.h>


struct nlist { 
    struct nlist *next;
    char *name;
    char *defn;
};

unsigned hash(char *s);
struct nlist *lookup(char *s);
struct nlist *install(char *name, char *defn);
int undef(char *name);
void printtable();
void testundef();

#define HASHSIZE 10
static struct nlist *hashtab[HASHSIZE]; /* pointer table */

int main()
{
    testundef();
}

void testundef() 
{
    install("HELLO", "1");
    install("HI", "1");
    install("LOL", "1");
    install("OK", "1");
    install("LMAO", "1");
    install("LMFAO", "1");
    printf("Before removal: \n");
    printtable();
    printf("Undef result: %d\n", undef("LOL"));
    printf("After removal: \n");
    printtable();
}



unsigned hash(char *s)
{
    unsigned hashval;
    for (hashval = 0; *s != '\0'; s++)
        hashval = *s + 31 * hashval;
    return hashval % HASHSIZE;
}

struct nlist *lookup(char *s)
{
    struct nlist *np;
    for (np = hashtab[hash(s)]; np != NULL; np = np->next) 
        if (strcmp(s, np->name) == 0)
            return np;     
    return NULL;
}

struct nlist *install(char *name, char *defn) 
{
    struct nlist *np;
    unsigned hashval;

    if ((np = lookup(name)) == NULL) { /* not found */
        np = (struct nlist *) malloc(sizeof(*np));
        if (np == NULL || (np->name = strdup(name)) == NULL)
            return NULL;

        hashval = hash(name);
        np->next = hashtab[hashval];
        hashtab[hashval] = np;
    } else /* already there */
        free((void *) np->defn); /*free previous defn */

    if ((np->defn = strdup(defn)) == NULL)
        return NULL;

    return np; 
}

int undef(char *name)
{
    struct nlist *np;
    unsigned hash_idx = hash(name);

    if ((np = hashtab[hash_idx]) != NULL) 
    {
        if (strcmp(name, np->name) == 0) {
            hashtab[hash_idx] = np->next;
            free((void *) np);
            return 1;
        }
        else if (np->next == NULL) //This is the only element in the array and it doesn't match the name. Return false.
            return 0;
    }
    
    np = np->next;
    struct nlist *prev_name;

    for (prev_name = hashtab[hash_idx]; np != NULL; np = np->next, prev_name = prev_name->next) {
        if (strcmp(name, np->name) == 0) {
            prev_name->next = np->next;
            free((void *) np);
            return 1;
        } 

    }

    return 0; //Did not find element to undef.
}

void printtable() 
{
    for (int i = 0; i < HASHSIZE; i++) {
        printf("%d: ", i);
        struct nlist *p;
        for (p = hashtab[i]; p != NULL; p = p->next)
            printf("%s ", p->name);
        printf("\n");
    }
}