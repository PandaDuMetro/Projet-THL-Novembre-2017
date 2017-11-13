%{
  #include <stdio.h>
  #include <stdlib.h>
  #include "calculette.tab.h"
%}

%%

[0-9]+(\.[0-9]*)?([Ee][0-9]+)? {  yylval = atof(yytext); return NUM; }

sin|sinus|Sin|Sinus|SINUS|SIN {  return SIN; }
cos|cosinus|Cos|Cosinus|COSINUS|COS {  return COS; }
tan|tangente|Tan|Tangente|TANGENTE|TAN { return TAN; }
asin|Asin|ASIN { return ASIN; }
acos|Acos|ACOS { return ACOS; }
atan|Atan|ATAN { return ATAN; }
sinh|Sinh|SINH { return SINH; }
cosh|Cosh|COSH { return COSH; }
tanh|Tanh|TANH { return TANH; }


exp|Exp|EXP {return EXP; }
sqrt|Sqrt|SQRT {return SQRT; }
log|Log|LOG {return LOG; }
abs|Abs|ABS {return ABS; }

Pi|PI|pi    {  yylval = 3.14159265359; return NUM; }
x|X { return VAR; }
un     {  yylval = 1.; return NUM; }
\n     {  return '\n'; }
plus   { return '+'; }
fois   { return '*'; }
moins  { return '-'; }
sur    { return '/'; }
\^     {return '^'; }
" "    {}
.      {  return yytext[0]; }

%%

int yywrap(){}
