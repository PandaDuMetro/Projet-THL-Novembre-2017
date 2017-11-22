%{
  #include <stdio.h>
  #include <stdlib.h>
  #include "calculette.tab.h"

  #include <string>
  using namespace std;
  
  #include "calculette.bison.hpp" 
%}

%%

[0-9]+(\.[0-9]*)?([Ee][0-9]+)? {  yylval.dval = atof(yytext); return NUM; }

sin|sinus|Sin|Sinus|SINUS|SIN {  return SIN; }
cos|cosinus|Cos|Cosinus|COSINUS|COS {  return COS; }
tan|tangente|Tan|Tangente|TANGENTE|TAN { return TAN; }
asin|Asin|ASIN { return ASIN; }
acos|Acos|ACOS { return ACOS; }
atan|Atan|ATAN { return ATAN; }
sinh|Sinh|SINH { return SINH; }
cosh|Cosh|COSH { return COSH; }
tanh|Tanh|TANH { return TANH; }
plot|Plot|PLOT { return PLOT; }


exp|Exp|EXP {return EXP; }
sqrt|Sqrt|SQRT {return SQRT; }
cbrt|Cbrt|CBRT {return CBRT; }
log|Log|LOG {return LOG; }
abs|Abs|ABS {return ABS; }
fact|Fact|FACT {return FACT;}

Pi|PI|pi    {  yylval.dval = 3.14159265359; return NUM; }
[a-zA-Z_][a-zA-Z_0-9]* { strcpy( yylval.sval, yytext); return VAR; }
un     {  yylval.dval = 1.; return NUM; }
\n     {  return '\n'; }
plus   { return '+'; }
fois   { return '*'; }
moins  { return '-'; }
sur    { return '/'; }
egal   { return '='; }
\^     { return '^'; }
" "    {}
.      {  return yytext[0]; }

%%

int yywrap(){}
