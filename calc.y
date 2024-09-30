%{
#define CALC_NORMAL
#include <stdio.h>
#include <stdlib.h>
#include <math.h>  

void yyerror(const char *s);
int yylex(void);
void print_value(float value);  

%}
%{
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

%%
calclist:
    | calclist exp EOL   { print_value($2); }
    ;

exp:
    factor                { $$ = $1; }
    | exp ADD factor      { $$ = $1 + $3; printf("3er valor"); print_value($3); }
    | exp SUB factor      { $$ = $1 - $3; printf("3er valor"); print_value($3); }
    ;

factor:
    term                  { $$ = $1; }   
    | factor MUL term     { $$ = $1 * $3; printf("3er valor"); print_value($3); }
    | factor DIV term     { 
        if ($3 == 0) {
            printf("Error: División por cero\n");
            $$ = 0;
        } else {
            $$ = $1 / $3; %{
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

%%
calclist:
    | calclist exp EOL   { print_value($2); }
    ;

exp:
    factor                { $$ = $1; }
    | exp ADD factor      { $$ = $1 + $3; printf("3er valor"); print_value($3); }
    | exp SUB factor      { $$ = $1 - $3; printf("3er valor"); print_value($3); }
    ;

factor:
    term                  { $$ = $1; }   
    | factor MUL term     { $$ = $1 * $3; printf("3er valor"); print_value($3); }
    | factor DIV term     { 
        if ($3 == 0) {
            printf("Error: División por cero\n");
            $$ = 0;
        } else {
            $$ = $1 / $3; 
        }
        printf("3er valor"); 
        print_value($3);
    }
    ;

term:
    NUMBER                { $$ = $1; }
    | ADD NUMBER          { $$ = +$2; }
    | SUB NUMBER          { $$ = -$2; }
    | ABS term ABS        { $$ = $2 >= 0 ? $2 : -$2; printf("No hay 3er valor\n"); }  
    | LPAREN exp RPAREN  { $$ = $2; }
    | SUB LPAREN exp RPAREN { $$ = -$3; printf("3er valor");  print_value($3); }
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

        }
        printf("3er valor"); 
        print_value($3);
    }
    ;

term:
    NUMBER                { $$ = $1; }
    | ADD NUMBER          { $$ = +$2; }
    | SUB NUMBER          { $$ = -$2; }
    | ABS term ABS        { $$ = $2 >= 0 ? $2 : -$2; printf("No hay 3er valor\n"); }  
    | LPAREN exp RPAREN  { $$ = $2; }
    | SUB LPAREN exp RPAREN { $$ = -$3; printf("3er valor");  print_value($3); }
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

    float val; 
}

%token <val> NUMBER
%token ADD SUB MUL DIV ABS
%token EOL
%token LPAREN RPAREN

%type <val> exp factor term

%%
calclist:
    | calclist exp EOL   { print_value($2); }
    ;

exp:
    factor                { $$ = $1; }
    | exp ADD factor      { $$ = $1 + $3; printf("3er valor"); print_value($3); }
    | exp SUB factor      { $$ = $1 - $3; printf("3er valor"); print_value($3); }
    ;

factor:
    term                  { $$ = $1; }   
    | factor MUL term     { $$ = $1 * $3; printf("3er valor"); print_value($3); }
    | factor DIV term     { 
        if ($3 == 0) {
            printf("Error: División por cero\n");
            $$ = 0;
        } else {
            $$ = $1 / $3; 
        }
        printf("3er valor"); 
        print_value($3);
    }
    ;

term:
    NUMBER                { $$ = $1; }
    | ADD NUMBER          { $$ = +$2; }
    | SUB NUMBER          { $$ = -$2; }
    | ABS term ABS        { $$ = $2 >= 0 ? $2 : -$2; printf("No hay 3er valor\n"); }  
    | LPAREN exp RPAREN  { $$ = $2; }
    | SUB LPAREN exp RPAREN { $$ = -$3; printf("3er valor");  print_value($3); }
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
