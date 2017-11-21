%{
/*
 * Word recognizer with a symbol table
 */

enum {
  LOOKUP = 0,  /* default - looking rather than defining. */
  VERB,
  ADJ,
  NOUN,
  PREP,
  PRON,
  CONJ
};

int state;

int add_word(int type, char *word);
int lookup_word(char *word);

%}

%%
