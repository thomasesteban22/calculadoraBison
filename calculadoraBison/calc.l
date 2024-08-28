%{
#include "calc.tab.h"
#include <stdlib.h> // Para atoi
%}

%option noyywrap

NUMBER [0-9]+
ADD "+"
SUB "-"
MUL "*"
DIV "/"
ABS "\|"
LPAREN "("
RPAREN ")"

%%

{NUMBER}    { yylval.val = atoi(yytext); return NUMBER; }
{ADD}       { return ADD; }
{SUB}       { return SUB; }
{MUL}       { return MUL; }
{DIV}       { return DIV; }
{ABS}       { return ABS; }
{LPAREN}    { return LPAREN; }
{RPAREN}    { return RPAREN; }
\n          { return EOL; }
[ \t]       ; // Ignorar espacios y tabulaciones
.           { printf("Caracter no reconocido: %s\n", yytext); }

%%
