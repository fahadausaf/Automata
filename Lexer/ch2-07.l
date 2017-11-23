%option noyywrap
%{
/* Start state example ch2-07.l */
%}

%s MAGIC

%%
<MAGIC>.+   { BEGIN 0; printf("Magic:"); ECHO;}
magic       BEGIN MAGIC;
%%

main(){
  yylex();
}
