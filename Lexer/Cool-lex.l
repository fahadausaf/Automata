%option noyywrap
%{
/*
 * COOL token recognizer with a symbol table
 */
enum {
  CLASS,
  ELSE,
  FI,
  IF,
  IN,
  INHERITS,
  LET,
  LOOP,
  POOL,
  THEN,
  WHILE,
  CASE,
  ESAC,
  OF,
  DARROW,
  NEW,
  ISVOID,
  STR_CONST,
  INT_CONST,
  BOOL_CONST,
  TYPEID,
  OBJECTID,
  ASSIGN,
  NOT,
  LE,
  ERROR,
  LET_STMT
};

%}
