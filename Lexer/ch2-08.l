%option noyywrap
%{
/* Broken start state example */
%}

%s Magic

%%
magic     BEGIN MAGIC;
.+        ECHO;
<MAGIC>.+ { BEGIN 0; printf("Magic:"); ECHO; }
%%

main(){
  yylex();
}
