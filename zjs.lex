%{
    #include <stdio.h>
	#include <stdlib.h>
	void printLexeme();
	
%}
 
%%

^\$exit$											{printf("END\n"); return 0;}	// Exits Interpreter
\;$													{printf("END_STATEMENT"); printLexeme();}	// ; Will be used to end sentences
\(\-?[0-9]+\.?[0-9]?+?,\-?[0-9]+\.?[0-9]?+?\)		{printf("POINT"); printLexeme();}	// (#,#) will represent the x and y values of a point
\(\(\-?[0-9]+\.?[0-9]?+?,\-?[0-9]+\.?[0-9]?+?\),\(\-?[0-9]+\.?[0-9]?+?,\-?[0-9]+\.?[0-9]?+?\)\)	{printf("LINE"); printLexeme();}	// ((#,#),(#,#)) two points will be used to draw the line
\(\(\-?[0-9]+\.?[0-9]?+?,\-?[0-9]+\.?[0-9]?+?\),[0-9]+\.?[0-9]?+?\)		{printf("CIRCLE"); printLexeme();}	// ((#,#),#) circle center at point followed by length of radius
\(\(\-?[0-9]+\.?[0-9]?+?,\-?[0-9]+\.?[0-9]?+?\),\(\-?[0-9]+\.?[0-9]?+?,\-?[0-9]+\.?[0-9]?+?\),\(\-?[0-9]+\.?[0-9]?+?,\-?[0-9]+\.?[0-9]?+?\),\(\-?[0-9]+\.?[0-9]?+?,\-?[0-9]+\.?[0-9]?+?\)\)	{printf("RECTANGLE"); printLexeme();}	// ((#,#),(#,#),(#,#),(#,#)) corners of rectangle each represented by a point
\([1-2]?[0-9]?[0-9],[1-2]?[0-9]?[0-9],[1-2]?[0-9]?[0-9]\)		{printf("SET_COLOR"); printLexeme();}	// (#,#,#) Color determined by sRBG coordinates
\-?[0-9]+      									{printf("INT"); printLexeme();}		// # can be negative and have as many digits as needed
\-?[0-9]+\.[0-9]+      							{printf("FLOAT"); printLexeme();}	// #.# can be negative and have as many digits as needed before and after the .
[ \t\n]+      											{putchar(' ');}		// Cleans up whitespace to a single space
.												{printf("ERROR "); printLexeme(); printf(" Not Recognized.");}	// Matches any unrecognized characters and displays them
 
%%
void printLexeme(){
	printf("(%s)", yytext);
}
 
int main(int argc, char** argv){
  yylex();    // Start lexing!
  return 0;
}