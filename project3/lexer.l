%option yylineno
%pointer

%{
    #include <cstdlib>
    #include <cerrno>
    #include <climits>
    #include <limits>
    #include "parser.hpp"
    
        void yyerror(const char *);

%}

/* WRITEME: Write any definitions here. You can find information on
definitions here:ftp://ftp.gnu.org/old-gnu/Manuals/flex-2.5.4/html_mono/flex.html#SEC10 */



/* WRITEME: If you are going to use start conditions, write them here.
            You can find more information on start conditions here:
            ftp://ftp.gnu.org/old-gnu/Manuals/flex-2.5.4/html_mono/flex.html#SEC11
            You will probably want to use exclusive conditions rather
            than inclusive conditions (use the %x instead of the %s). */

%x COMMENT
%s INIT
%%


"/*" BEGIN(COMMENT);

<COMMENT>[^*\n]*

<COMMENT>"*"+[^*/\n]*
<COMMENT>\n
<COMMENT>"*"+"/" BEGIN(INIT);
<COMMENT><<EOF>> {yyerror("EOF inside Comment");}


[ \n\t]+ 
"false" {return FALSE;}
"return" {return RETURN;}
"new" {return NEW;}
"integer" {return INT;}
"boolean" {return BOOL;}
"none" {return NONE;}
"extends" {return EXTENDS;}
"do" {return DO;}
"true" {return TRUE;}
"if" {return IF;}
"else" {return ELSE;}
"not" {return NOT;}
"equals" {return EQ;}
"and" {return AND;}
"or" {return OR;}
"while" {return WHILE;}
"do" {return DO;}
"for" {return FOR;}
"print" {return PRINT;}
"=" {return ASSIGN;}
">" {return GT;}
">=" {return GTE;}
[1-9][0-9]*|0 {return LITERAL;}
[a-z][a-z0-9]* {return ID;}

"{" {return LB;}
"}" {return RB;}
"." {return DOT;}
"->" {return FUNCTION;}
"(" {return LP;}
")" {return RP;}
"," {return COMMA;}
";" {return SEMI;}
"+" {return PLUS;}
"-" {return MINUS;}
"*" {return MULT;}
"/" {return DIV;}


.                 { yyerror("invalid character"); }

%%

int yywrap(void) {
  return 1;
}
