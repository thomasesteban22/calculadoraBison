%{
#include <stdio.h>
#include <stdlib.h>

void yyerror(const char *s);
int yylex(void);
%}

%union {
    int val;
}

%token <val> NUMBER
%token ADD SUB MUL DIV ABS
%token EOL
%token LPAREN RPAREN

%type <val> exp factor term

%%
calclist:
    | calclist exp EOL   { printf("= %d\n", $2); }
    ;

exp:
    factor                { $$ = $1; }
    | exp ADD factor      { $$ = $1 + $3; }
    | exp SUB factor      { $$ = $1 - $3; }
    ;

factor:
    term                  { $$ = $1; }
    | factor MUL term     { $$ = $1 * $3; }
    | factor DIV term     { 
        if ($3 == 0) {
            printf("Error: División por cero\n");
            exit(1);  // Terminar el programa en caso de error
        } else {
            $$ = $1 / $3; 
        }
    }
    ;

term:
    NUMBER                { $$ = $1; }
    | ADD NUMBER          { $$ = +$2; }
    | SUB NUMBER          { $$ = -$2; }
    | ABS term ABS        { $$ = $2 >= 0 ? $2 : -$2; }  
    | LPAREN exp RPAREN  { $$ = $2; }
    | SUB LPAREN exp RPAREN { $$ = -$3; }
    ;

%%

int main(int argc, char **argv)
{
    printf("Ingrese la operación:\n");
    return yyparse();
}

void yyerror(const char *s)
{
    fprintf(stderr, "error: %s\n", s);
}