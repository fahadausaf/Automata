%option noyywrap
%{
/*
 * We expand upon the first example by adding recognition of some other
 * parts of speech.
 */

%}
%%

[\t ]+    /* ignore whitespace */ ;

is |
am |
are |
were |
was |
be |
being |
been |
do |
does |
did |
will |
would |
should |
can |
could |
has |
have |
had |
go      { printf("%s: is a verb\n", yytext); }

very |
simply |
gently |
quitely |
calmly |
angrily   { printf("%s: is an adverb\n", yytext); }

to |
from |
behind |
above |
below |
between |
below     { printf("%s: is a preposition\n", yytext); }

if |
then |
and |
but |
or        { printf("%s: is a conjunction\n", yytext); }

their |
my |
your |
his |
her |
its       { printf("%s: is an adjective\n"); }
