/*
 *  The scanner definition for COOL.
 */

/*
 *  Stuff enclosed in %{ %} in the first section is copied verbatim to the
 *  output, so headers and global definitions are placed here to be visible
 * to the code in the file.  Don't remove anything that was here initially
 */
%{
#include <cool-parse.h>
#include <stringtab.h>
#include <utilities.h>

/* The compiler assumes these identifiers. */
#define yylval cool_yylval
#define yylex  cool_yylex

/* Max size of string constants */
#define MAX_STR_CONST 1025
#define YY_NO_UNPUT   /* keep g++ happy */

extern FILE *fin; /* we read from this file */

/* define YY_INPUT so we read from the FILE fin:
 * This change makes it possible to use this scanner in
 * the Cool compiler.
 */
#undef YY_INPUT
#define YY_INPUT(buf,result,max_size) \
	if ( (result = fread( (char*)buf, sizeof(char), max_size, fin)) < 0) \
		YY_FATAL_ERROR( "read() in flex scanner failed");

char string_buf[MAX_STR_CONST]; /* to assemble string constants */
char *string_buf_ptr;

extern int curr_lineno;
extern int verbose_flag;

extern YYSTYPE cool_yylval;

/*
 *  Add Your own definitions here
 */

%}

/*
 * Define names for regular expressions here.
 */


CLASS             [Cc][Ll][Aa][Ss][Ss]
ELSE		          [Ee][Ll][Ss][Ee]
FALSE		          f[Aa][Ll][Ss][Ee]
FI		            [Ff][Ii]
IF		            [Ii][Ff]
IN		            [Ii][Nn]
INHERITS	        [Ii][Nn][Hh][Ee][Rr][Ii][Tt][Ss]
ISVOID		        [Ii][Ss][Vv][Oo][Ii][Dd]
LET		            [Ll][Ee][Tt]
LOOP              [Ll][Oo][Oo][Pp]
POOL              [Pp][Oo][Oo][Ll]
THEN              [Tt][Hh][Ee][Nn]
WHILE         		[Ww][Hh][Ii][Ll][Ee]
CASE          		[Cc][Aa][Ss][Ee]
ESAC          		[Ee][Ss][Aa][Cc]
NEW           		[Nn][Ee][Ww]
OF            		[Oo][Ff]
NOT		            [Nn][Oo][Tt]
TRUE		          t[Rr][Uu][Ee]

DIGIT             [0-9]
INTEGER           {DIGIT}+
TYPEID		        [A-Z][a-zA-Z0-9_]*
OBJECTID	        [a-z][a-zA-Z0-9_]*
SELFID            "self"
SELF_TYPEID       "SELF_TYPE"

NEWLINE     \n
TAB         \t
BACKSPACE   \b
FORMFEED    \f
NULLCHAR    \0
START_COMMENT   "(*"
END_COMMENT     "*)"
LINE_COMMENT    "--"

ASSIGN      <-
PLUS        +
MINUS       *
DIV         /
TILDA       ~
LT          <
LE		      <=
EQ          =
OPENPAREN   (
CLOSEPAREN  )
COLON       :
SEMICOLON   ;
COMMA       ,
DARROW      =>

%x COMMENT
%x STRING

%%

 /*
  *  Nested comments
  */


 /*
  *  The multiple-character operators.
  */

{CLASS}       {return (CLASS);}
{ELSE}        {return (ELSE);}
{FALSE}       {return (FALSE);}
{FI}          {return (FI);}
{IF}          {return (IF);}
{IN}          {return (IN);}
{INHERITS}    {return (INHERITS);}
{ISVOID}      {return (ISVOID);}
{LET}         {return (LET);}
{LOOP}        {return (LOOP);}
{POOL}        {return (POOL);}
{THEN}        {return (THEN);}
{WHILE}       {return (WHILE);}
{CASE}        {return (CASE);}
{ESAC}        {return (ESAC);}
{NEW}         {return (NEW);}
{OF}          {return (OF);}
{NOT}         {return (NOT);}
{TRUE}        {return (TRUE);}

{ASSIGN}		  { return (ASSIGN); }
{PLUS}		    { return (PLUS); }
{MINUS}		    { return (MINUS); }
{DIV}		      { return (DIV); }
{TILDA}		    { return (TILDA); }
{LT}		      { return (LT); }
{LE}		      { return (LE); }
{EQ}		      { return (EQ); }
{OPENPAREN}		{ return (OPENPAREN); }
{CLOSEPAREN}	{ return (CLOSEPAREN); }
{COLON}		    { return (COLON); }
{SEMICOLON}		{ return (SEMICOLON); }
{COMMA}		    { return (COMMA); }
{DARROW}		  { return (DARROW); }

--[^\n]*		  { }
\n			      { curr_lineno++; }

"(*"			{
	int c;
	int nst = 1;
	while ((c = yyinput()) != 0)
	{
		if (c == '\n')
			curr_lineno++;
		else if (c == '*')
		{
			int cc = yyinput();
			if (cc == ')')
			{
				if (--nst == 0) break;
			}
			else
				unput(cc);
		}
		else if (c == '(')
		{
			int cc = yyinput();
			if (cc == '*')
				nst++;
			else
				unput(cc);
		}
		if (EOF == c)
		{
			if (ineof)
				yyterminate();
			ERR("EOF in comment");

		}
	}

	ASS(0 == c, "Comments contains null character");
} // end of comments


"*)" 			{ ERR("Unmatched *)"); }




 /*
  * Keywords are case-insensitive except for the values true and false,
  * which must begin with a lower-case letter.
  */



 /*
  *  String constants (C syntax)
  *  Escape sequence \c is accepted for all characters c. Except for
  *  \n \t \b \f, the result is c.
  *
  */


%%
