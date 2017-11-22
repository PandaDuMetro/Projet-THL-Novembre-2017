%{
  #include <stdio.h>
  #include <stdlib.h>
  #include <math.h>    
  #include <map>
  #include <vector>
  #include <string>
  #include <SFML/Window.hpp>

  using namespace std;
  extern int yylex ();
  extern char* yytext;

  int yyerror(char *s)
  { printf("%s\n", s); }

  double varx = 0.;


  map<string, double> variables;

  vector<pair<int,double> > postfixed;
  map<string, vector<pair<int,double> > > functions;
  vector<float> pile;

%}

%union
{
  double dval;
  char sval[40];
}

%token <dval> NUM
%token <sval> VAR 
%type <dval> expr
%token PLOT
%token TAN SIN COS ACOS ASIN ATAN SINH COSH TANH LOG SQRT CBRT EXP ABS FACT
%token PLUS MOINS FOIS DIVISE POW
%left '+' '-'
%left '*' '/'
%left '^' '='

%%
program: /* empty */    
       | program line          
     ;

line: '\n'       
  | expr '\n' { printf("\nResult : %g\n", $1); }  
  | VAR '('VAR')' '=' expr {functions[$1] = postfixed; postfixed.clear();}
  | PLOT '(' VAR ')' { printf("coucou"); /*eval($3)*/}
    ;
  

expr:
     NUM                 { postfixed.push_back(make_pair(NUM,$1)); } 
     | VAR               { $$ = variables[$1]; postfixed.push_back(make_pair(VAR,0));}


     | expr '+' expr     { postfixed.push_back(make_pair(PLUS,0)); }
     | expr '-' expr     { postfixed.push_back(make_pair(MOINS,0));  }       
     | expr '*' expr     { postfixed.push_back(make_pair(FOIS,0));  }
     | expr '/' expr     { postfixed.push_back(make_pair(DIVISE,0));  }  
     | expr '^' expr     { postfixed.push_back(make_pair(POW,0));  } 

     | '(' expr ')'      { $$ = $2;  }
     | '-' expr          { $$ = -$2;}



     | SIN '(' expr ')'  { postfixed.push_back(make_pair(SIN,0)); }
     | COS '(' expr ')'  { postfixed.push_back(make_pair(COS,0)); }
     | TAN '(' expr ')'  { postfixed.push_back(make_pair(TAN,0)); }
     | ASIN '(' expr ')' { postfixed.push_back(make_pair(ASIN,0)); }
     | ACOS '(' expr ')' { postfixed.push_back(make_pair(ACOS,0)); }
     | ATAN '(' expr ')' { postfixed.push_back(make_pair(ATAN,0)); }
     | SINH '(' expr ')' { postfixed.push_back(make_pair(SINH,0)); }
     | COSH '(' expr ')' { postfixed.push_back(make_pair(COSH,0)); }
     | TANH '(' expr ')' { postfixed.push_back(make_pair(TANH,0)); }


     | EXP '(' expr ')'  { postfixed.push_back(make_pair(EXP,0));}
     | SQRT '(' expr ')' { if($3> 0) { postfixed.push_back(make_pair(SQRT,0)); } else{ $$=-1; printf("Square root needs a positive value");}}
     | CBRT '(' expr ')' { if($3> 0) { postfixed.push_back(make_pair(CBRT,0)); } else{ $$=-1; printf("cubic root needs a positive value");}}
     | LOG '(' expr ')'  { if($3> 0) { postfixed.push_back(make_pair(LOG,0)); } else{ $$=-1; printf("Log needs a positive value");}}
     | ABS '(' expr ')'  { postfixed.push_back(make_pair(ABS,0)); }
     //| FACT '(' expr ')' { if($3>1)  {$$=$3*FACT($3 -1);} else{$$=1; printf("fact(%g) = %g\n",$3, $$)};}



%%

float depiler_operande(int func, int i, string name){
  float v1 = pile.back();
  pile.pop_back();
  float v2;
  switch (func){
    case PLUS:
        v2 = pile.back();
        pile.pop_back();
        return(v2+v1);
      break;
    case MOINS:
        v2 = pile.back();
        pile.pop_back();
        return(v2-v1);
      break;
    case FOIS:
      v2 = pile.back();
      pile.pop_back();
      return(v2*v1);
      break;
    case DIVISE:
      v2 = pile.back();
      pile.pop_back();
      return(v2/v1);
      break;
    case POW:
      v2 = pile.back();
      pile.pop_back();
      return(pow(v2,v1));
      break;
    case SIN:
      return(sin(v1));
      break;
    case COS:
      return(cos(v1));
      break;
    case SQRT:
      return(sqrt(v1));
      break;
    case EXP:
      return(exp(v1));
      break;
    case TAN:
      return(tan(v1));
      break;
    case ACOS:
      return(acos(v1));
      break;
    case ASIN:
      return(asin(v1));
      break;
    case ATAN:
      return(atan(v1));
      break;
    case SINH:
      return(sinh(v1));
      break;
    case COSH:
      return(cosh(v1));
      break;
    case TANH:
      return(tanh(v1));
      break;
    case LOG:
      return(log(v1));
      break;

  }
}

int main(void) {
    yyparse();            

  return 0;
}
