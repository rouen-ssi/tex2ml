%{
#include <stdlib.h>
#include <stdio.h>
#include <string.h>

#define YYSTYPE char *
#define MROW_OPEN   "<mrow>"
#define MROW_CLOSE  "</mrow>"
#define MN_OPEN     "<mn>"
#define MN_CLOSE    "</mn>"
#define MI_OPEN     "<mi>"
#define MI_CLOSE    "</mi>"
#define MO_OPEN     "<mo>"
#define MO_CLOSE    "</mo>"
#define MSQRT_OPEN  "<msqrt>"
#define MSQRT_CLOSE "</msqrt>"
#define MFRAC_OPEN  "<mfrac>"
#define MFRAC_CLOSE "</mfrac>"
#define MSUP_OPEN   "<msup>"
#define MSUP_CLOSE  "</msup>"
#define MUO_OPEN    "<munderover>"
#define MUO_CLOSE   "</munderover>"

int yylex(void);
void yyerror(char *);

char mathml[100000];
%}

%token SQRT
%token OPEN_BRACE
%token CLOSE_BRACE
%token CHAR
%token NUM
%token OP
%token POW
%token FRAC
%token SEQ

%start statement

%%
statement:
	expr { printf("<math display=\"block\">%s</math>\n", mathml); };

expr:
	expr identifier
	| expr numeric
	| expr operator
	| expr sqrt
	| expr frac
	| expr sequences
	|
;

sqrt:
	SQRT { strcat(mathml, MSQRT_OPEN); }
	OPEN_BRACE { strcat(mathml, MROW_OPEN); }
	expr { strcat(mathml, MROW_CLOSE); }
	CLOSE_BRACE { strcat(mathml, MSQRT_CLOSE); }
;

frac:
	FRAC { strcat(mathml, MFRAC_OPEN); }
	OPEN_BRACE { strcat(mathml, MROW_OPEN); }
	expr { strcat(mathml, MROW_CLOSE); }
	CLOSE_BRACE
	OPEN_BRACE { strcat(mathml, MROW_OPEN); }
	expr { strcat(mathml, MROW_CLOSE); }
	CLOSE_BRACE { strcat(mathml, MFRAC_CLOSE); }
;

sequences:
	SEQ
	OPEN_BRACE {
		strcat(mathml, MUO_OPEN);
		strcat(mathml, $1);
		strcat(mathml, MROW_OPEN); }
	expr {
		strcat(mathml, MROW_CLOSE);
	}
	CLOSE_BRACE
	POW
	OPEN_BRACE {
		strcat(mathml, MROW_OPEN);
	} expr {
		strcat(mathml, MROW_CLOSE);
		strcat(mathml, MUO_CLOSE);
	}
	CLOSE_BRACE
;

numeric:
	NUM {
		strcat(mathml, MN_OPEN);
		strcat(mathml, $1);
		strcat(mathml, MN_CLOSE);
	}
;

identifier:
	CHAR {
		strcat(mathml, MI_OPEN);
		strcat(mathml, $1);
		strcat(mathml, MI_CLOSE);
	}
;

operator:
	OP {
		strcat(mathml, MO_OPEN);
		strcat(mathml, $1);
		strcat(mathml, MO_CLOSE);
	}
;
%%