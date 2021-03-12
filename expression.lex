%{
#include "y.tab.h"
void yyerror (char *);
%}

DIGIT [0-9]
VAR [_a-zA-Z]+[_a-zA-Z0-9]+
CHAR [a-zA-Z]
OPER "+"|"*"|"-"

%%
{DIGIT}+                   	       {yylval.num = atoi(yytext);return NUMBER;}	
{VAR}                              {yylval.var = yytext;return VAR;} 
{CHAR}                             {yylval.c = yytext[0];return CHAR;}     	
=                                  {return EQEQ;};
{OPER}							               {return yytext[0];}
[ \t\n]	                           ; 
.                                 {return yytext[0];}

%%
int yywrap (void)  {return 1;}
