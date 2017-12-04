%token NAME NUMBER
%%
statement:  NAME '=' expression
    |       expression        { printf("= %d\n", $1); }
    ;

expression: NUMBER '+' NUMBER   { $$ = $1 + $3; }
    |       NUMBER '-' NUMBER   { $$ = $1 - $3; }
    |       NUMBER              { $$ = $1; }
    ;
