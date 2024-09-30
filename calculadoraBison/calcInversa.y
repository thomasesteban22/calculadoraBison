%{
#define CALC_INVERSA
#include <stdio.h>
#include <stdlib.h>
#include <math.h>

void yyerror(const char *s);
int yylex(void);
void print_value(float value);
%}

%union {
    float val;
}

%token <val> NUMBER
%token ADD SUB MUL DIV ABS
%token EOL
%token LPAREN RPAREN

%type <val> exp factor term

// Precedencia invertida
%left ADD SUB
%right MUL DIV

%%

calclist:
    | calclist exp EOL   { print_value($2); }
    ;

exp:
    factor                { $$ = $1; }
    | exp ADD factor      { $$ = $1 + $3; }
    | exp SUB factor      { $$ = $1 - $3; }
    | exp MUL factor      { $$ = $1 * $3; }
    | exp DIV factor      {
        if ($3 == 0) {
            yyerror("División por cero");
            $$ = 0;
        } else {
            $$ = $1 / $3;
        }
    }
    ;

factor:
    term                  { $$ = $1; }
    | LPAREN exp RPAREN   { $$ = $2; }
    ;

term:
    NUMBER                { $$ = $1; }
    | ADD NUMBER          { $$ = +$2; }
    | SUB NUMBER          { $$ = -$2; }
    | ABS term ABS        { $$ = $2 >= 0 ? $2 : -$2; }
    ;

%%

void print_value(float value) {
    if (fmod(value, 1.0) == 0.0) {
        printf("= %d\n", (int)value);
    } else {
        printf("= %.3f\n", value);
    }
}

int main(int argc, char **argv)
{
    printf("Ingrese la operación:\n");
    return yyparse();
}

void yyerror(const char *s)
{
    fprintf(stderr, "error: %s\n", s);
}
