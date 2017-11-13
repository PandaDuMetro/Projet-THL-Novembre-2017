%{
  #include <stdio.h>
  #include <stdlib.h>
  #include <math.h>    
  #include <map>
  #include <string>

  using namespace std;
  extern int yylex ();
  extern char* yytext;

  int yyerror(char *s)
  { printf("%s\n", s); }

  double varx = 0.;


  map<string, double> variables;

%}

%union
{
  double dval;
  char sval[40];
}


%token <dval> NUM
%token <sval> VAR 
%type <dval> expr
%token TAN SIN COS ACOS ASIN ATAN SINH COSH TANH LOG SQRT CBRT EXP ABS
%left '+' '-'
%left '*' '/'
%left '^'

%%
program: /* empty */    
       | program line          
     ;

line: '\n'       
  | expr '\n' { printf("\nResult : %g\n", $1); }  
  | VAR '=' expr   { variables[$1] = $3; } 
    ;

expr:
     NUM                 { $$ = $1;  /* printf("%g ", $1); */ } 
     | VAR               { $$ = variables[$1]  ; /*printf("VAR:%s\n", $1);*/ }


     | expr '+' expr     { $$ = $1 + $3;  printf("%g + %g = %g\n", $1, $3, $$); }
     | expr '-' expr     { $$ = $1 - $3;  printf("%g - %g = %g\n", $1, $3, $$); }       
     | expr '*' expr     { $$ = $1 * $3;  printf("%g * %g = %g\n", $1, $3, $$); }
     | expr '/' expr     { $$ = $1 / $3;  printf("%g / %g = %g\n", $1, $3, $$); }  
     | expr '^' expr     { $$ = pow($1,$3); printf("%g ^ %g = %g\n", $1, $3, $$); } 

     | '(' expr ')'      { $$ = $2;  }
     | '-' expr          { $$ = -$2;}


     | SIN '(' expr ')'  { $$ = sin($3);  printf("sin(%g) = %g\n", $3, $$); }
     | COS '(' expr ')'  { $$ = cos($3);  printf("cos(%g) = %g\n", $3, $$); }
     | TAN '(' expr ')'  { $$ = tan($3);  printf("tan(%g) = %g\n", $3, $$); }
     | ASIN '(' expr ')' { $$ = asin($3); printf("asin(%g) = %g\n", $3, $$); }
     | ACOS '(' expr ')' { $$ = acos($3); printf("acos(%g) = %g\n", $3, $$); }
     | ATAN '(' expr ')' { $$ = atan($3); printf("atan(%g) = %g\n", $3, $$); }
     | SINH '(' expr ')' { $$ = sinh($3); printf("sinh(%g) = %g\n", $3, $$);}
     | COSH '(' expr ')' { $$ = cosh($3); printf("cosh(%g) = %g\n", $3, $$);}
     | TANH '(' expr ')' { $$ = tanh($3); printf("tanh(%g) = %g\n", $3, $$);}


     | EXP '(' expr ')'  { $$ = exp($3);  printf("exp(%g) = %g\n", $3, $$); }
     | SQRT '(' expr ')' { if($3> 0) { $$= sqrt($3); printf("sqrt(%g) = %g\n", $3, $$); } else{ $$=-1; printf("Square root needs a positive value");}}
     | CBRT '(' expr ')' { if($3> 0) { $$= cbrt($3); printf("cbrt(%g) = %g\n", $3, $$); } else{ $$=-1; printf("cubic root needs a positive value");}}
     | LOG '(' expr ')'  { if($3> 0) { $$= log($3); printf("log(%g) = %g\n", $3, $$); } else{ $$=-1; printf("Log needs a positive value");}}
     | ABS '(' expr ')'  { $$= sqrt(pow($3,2)); printf("abs(%g) = %g\n", $3,$$); }



%%


int main(void) {
    yyparse();            
    return 0;
}
