%{
  #include <stdio.h>
  #include <stdlib.h>
  #include <math.h>    
  extern int yylex ();

  double varx = 0.;
%}

%code requires
  {
    #define YYSTYPE double
  }


%token NUM
%token VAR TAN SIN COS ACOS ASIN ATAN SINH COSH TANH LOG SQRT EXP ABS
%left '+' '-'
%left '*' '/'
%left '^'

%%
program: /* empty */    
       | program line          
     ;

line: '\n'       
  | expr '\n' { printf("\nResult : %g\n", $1); }  
  | VAR '=' expr { varx = $3; }
  ;

expr:
     NUM                 { $$ = $1;  /* printf("%g ", $1); */ } 
   | VAR         { $$ = varx; }
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
     | LOG '(' expr ')'  { if($3> 0) { $$= log($3); printf("log(%g) = %g\n", $3, $$); } else{ $$=-1; printf("Log needs a positive value");}}
     | ABS '(' expr ')'  { $$= sqrt(pow($3,2)); printf("abs(%g) = %g\n", $3,$$); }

%%

yyerror(char *s) {          
    printf("%s\n", s);
}

int main(void) {
    yyparse();            
    return 0;
}
