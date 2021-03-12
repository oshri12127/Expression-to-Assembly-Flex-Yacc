%{
#include <stdio.h>
void yyerror (char *);
int yylex (void);
%}

%union   {int num;
          char* var;
          char c;
			};
%start program
%token <num>NUMBER
%token <var>VAR
%token EQEQ
%token <c>CHAR
%left '+' '-'
%left '*'
%%

program		: 
                  | program comparison ';'      
            	  ;

comparison	: 
         expr { printf ("\n");}
         | CHAR EQEQ expr
               { printf ("POP %c\n\n",$1);}
          
		; 
 expr:    
 
		 '(' expr ')'
		 | expr '+' expr { printf ("POP AX\nPOP BX\nADD BX\nPUSH AX\n");}
		 | expr '-' expr { printf ("POP AX\nPOP BX\nMINS BX\nPUSH AX\n");}
		 | expr '*' expr { printf ("POP AX\nPOP BX\nMUL BX\nPUSH AX\n");}
		 | NUMBER { printf ("PUSH %d\n",$1); }
     | VAR    { printf ("PUSH %s\n",$1); }
     | CHAR   { printf ("PUSH %c\n",$1); }
 
		;


%%
void yyerror (char *s) {fprintf (stderr,"syntax error\n");}

int main (void) {
    return yyparse();
}
