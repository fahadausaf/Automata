/* lexer with symbol table */

%{
#include "y.tab.h"
#include <math.h>
#include "ch3ex1hdr.h"
%}

%%
([0-9]+|([0-9]*\.[0-9]+)([eE][-+]?[0-9]+)?) {
  yylval.dval = atof(yytext);
  return NUMBER;
  }

[ \t] ;         /* ignore whitespace */

[A-Za-z][A-Za-z0-9]* {
  struct symtab *sp = symlook(yytext);
  yylval.symp = sp;
  return NAME;
}

"$"   { return 0; /* end of input */}

\n    |
.     return yytext[0];
%%
