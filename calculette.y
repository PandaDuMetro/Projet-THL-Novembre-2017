%{
  #include "link.h"

  using namespace std;
  extern int yylex ();
  extern char* yytext;
  extern FILE *yyin;
  int displayG(vector<pair<int,double> >,vector<pair<int,double> >);

  int yyerror(char *s)
  { printf("%s\n", s); }

  double varx = 0.;

  void eval(string);


  map<string, double> variables;

  vector<pair<int,double> > postfixed;
  map<string, vector<pair<int,double> > > functions;
  vector<float> pile;
  vector<vector<pair<int,double> > > plots;
  double xmin;
  double xmax;

%}

%union
{
  double dval;
  char sval[40];
}

%token <dval> NUM
%token <sval> VAR 
%type <dval> expr
%token PLOT DISPLAY COM
%token TAN SIN COS ACOS ASIN ATAN SINH COSH TANH LOG SQRT CBRT EXP ABS FACT
%token PLUS MOINS FOIS DIVISE POW COMP MOD
%left '+' '-'
%left '*' '/'
%left '^' '=' '!' '%'
%left '[' ']' ','

%%
program: /* empty */    
       | program line          
     ;

line: '\n'       
  | VAR '('VAR')' '=' expr {functions[$1] = postfixed; postfixed.clear();}
  | '[' NUM ',' NUM ']' {xmin = $2,xmax = $4;}
  | COM {}
  | PLOT '(' VAR ')' { eval($3);}
  | DISPLAY {displayG(plots);}
    ;
  

expr:
     NUM                 { postfixed.push_back(make_pair(NUM,$1)); } 
     | VAR               { $$ = variables[$1]; postfixed.push_back(make_pair(VAR,0));}


     | expr '+' expr     { postfixed.push_back(make_pair(PLUS,0)); }
     | expr '-' expr     { postfixed.push_back(make_pair(MOINS,0));  }       
     | expr '*' expr     { postfixed.push_back(make_pair(FOIS,0));  }
     | expr '/' expr     { postfixed.push_back(make_pair(DIVISE,0));  }  
     | expr '^' expr     { postfixed.push_back(make_pair(POW,0));  } 
     | expr '!'          { postfixed.push_back(make_pair(FACT,0));}
     | expr '%' expr     { postfixed.push_back(make_pair(MOD,0));}
 
     | '(' expr ')'      { $$ = $2;  }
     | '-' expr          { postfixed.push_back(make_pair(NUM,-1));
                           postfixed.push_back(make_pair(FOIS,0));}

     /*| expr COMP         { postfixed.push_back(make_pair(COMP,0));}*/



     | SIN '(' expr ')'  { postfixed.push_back(make_pair(SIN,0)); }
     | COS '(' expr ')'  { postfixed.push_back(make_pair(COS,0)); }
     | TAN '(' expr ')'  { postfixed.push_back(make_pair(TAN,0)); }
     | ASIN '(' expr ')' { postfixed.push_back(make_pair(ASIN,0)); }
     | ACOS '(' expr ')' { postfixed.push_back(make_pair(ACOS,0)); }
     | ATAN '(' expr ')' { postfixed.push_back(make_pair(ATAN,0)); }
     | SINH '(' expr ')' { postfixed.push_back(make_pair(SINH,0)); }
     | COSH '(' expr ')' { postfixed.push_back(make_pair(COSH,0)); }
     | TANH '(' expr ')' { postfixed.push_back(make_pair(TANH,0)); }


     | EXP '(' expr ')'  { postfixed.push_back(make_pair(EXP,0)); }
     | SQRT '(' expr ')' { postfixed.push_back(make_pair(SQRT,0));}
     | CBRT '(' expr ')' { postfixed.push_back(make_pair(CBRT,0));}
     | LOG '(' expr ')'  { postfixed.push_back(make_pair(LOG,0)); }
     | ABS '(' expr ')'  { postfixed.push_back(make_pair(ABS,0)); }



%%
int factorial(double x, int result = 1){
  if (x == 1){ 
    return result;
  }else{
    return factorial(x - 1, x * result);
    }
} 

double function_eval(vector<pair<int,double> > func_to_eval,double i){
  stack<double> storage;
  double temp;
  for(auto it:func_to_eval){
    switch(it.first){
      case NUM:
        storage.push(it.second);
        break;
      case VAR:
        storage.push(i);
        break;
      case PLUS:
        temp = storage.top();
        storage.pop();
        storage.top() += temp;
        break;
      case MOINS:
        temp = storage.top();
        storage.pop();
        storage.top() -= temp;
        break;
      case FOIS:
        temp = storage.top();
        storage.pop();
        storage.top() *= temp;
        break;
      case DIVISE:
        temp = storage.top();
        storage.pop();
        storage.top() /= temp;
        break;
      case POW:
        temp = storage.top();
        storage.pop();
        storage.top() = pow(storage.top(),temp);
        break;
      case FACT:
        storage.top() = factorial(storage.top());   
        break;
      case SIN:
        storage.top() = sin(storage.top());
        break;
      case ASIN:
        storage.top() = asin(storage.top());
        break;
      case SINH:
        storage.top() = sinh(storage.top());
        break;
      case COS:
        storage.top() = cos(storage.top());
        break;
      case ACOS:
        storage.top() = acos(storage.top());
        break;
      case COSH:
        storage.top() = cosh(storage.top());
        break;
      case TAN:
        storage.top() = tan(storage.top());
        break;
      case ATAN:
        storage.top() = atan(storage.top());
        break;
      case TANH:
        storage.top() = tanh(storage.top());
        break;
      case EXP:
        storage.top() = exp(storage.top());
        break;
      case SQRT:
        storage.top() = sqrt(storage.top());
        break;
      case CBRT:
        storage.top() = cbrt(storage.top());
        break;
      case ABS:
        storage.top() = abs(storage.top());
        break;
      case LOG:
        storage.top() = log(storage.top());
        break;
      /*case COMP:
        storage.top() = storage.top()*1.0i;
        break;*/
    }
  }
  return storage.top();
}

void eval(string fonc){
  if(functions.count(fonc)>0){
    plots.push_back(functions[fonc]);
  }else{
    cout << " no function entered" << endl;
  }


}

int main(void) {
    yyin = fopen("code.txt","r");
    yyparse();            
    fclose(yyin);
  return 0;
}
