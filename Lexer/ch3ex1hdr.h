/* Header for parser with symbol table */

#define NSYMS 20  /* maximum number of symbols */

struct symtab {
  char *name;
  double (*funcptr)();
  double value;
} symtab[NSYMS];

struct symtab *symlook();
