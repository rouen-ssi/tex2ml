%{
#define YYSTYPE char *

#include <stdlib.h>
#include "tex2ml.tab.h"

int yyparse(void);
%}

%%
[0-9]+\.?[0-9]* { yylval = strdup(yytext); return NUM; }
[a-zA-Z]        { yylval = strdup(yytext); return CHAR; }
\\frac          return FRAC;
\\sqrt          return SQRT;
\\sum_          { yylval = "<mo>&sum;</mo>"; return SEQ; }
\\prod_			{ yylval = "<mo>&prod;</mo>"; return SEQ; }
\\pm			{ yylval = "&plusmn;"; return OP; }
\\mp			{ yylval = "&#x2213;"; return OP; }
\\cap           { yylval = "&cap;"; return OP; }
\\cup           { yylval = "&cup;"; return OP; }
\\subset        { yylval = "&sub;"; return OP; }
\\subseteq      { yylval = "&sube;"; return OP; }
\\supset        { yylval = "&sup;"; return OP; }
\\supseteq      { yylval = "&supe;"; return OP; }
\{              return OPEN_BRACE;
\}              return CLOSE_BRACE;
\+|\-|\=        { yylval = strdup(yytext); return OP; }
\^              return POW;
.
%%

void yyerror(char *s) {
    fprintf(stderr, "%s\n", s);
}

int main(int argc, char** argv) {
	if (argc != 2) {
		fprintf(stderr, "No LaTeX expression given\n");
		exit(1);
	}

	yy_scan_string(argv[1]);
	yyparse();
	return 0;
}