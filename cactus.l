%{
    #include <stdio.h>
    #include <getopt.h>
    #include "cactus.tab.h"

    extern char *yytext;
    extern int yyleng;

%}

%option    noyywrap
%option    yylineno

delim               [ \t\r\n]
ws                  {delim}+
letter              [A-Za-z]
digit               [0-9]
underscore          [_]
constant            [digit]+

%%

"/""/".*      { /* no action and no return */ }
{ws}        { /* no action and no return */ }
And         { return (And); }
Begin       { return (Begin); }
Do          { return (Do); }
Else        { return (Else); }
End         { return (End); }
EndIf       { return (EndIf); }
EndWhile    { return (EndWhile); }
Exit        { return (Exit); }
If          { return (If); }
Set         { return (Set); }
Not         { return (Not); }
Or          { return (Or); }
Program     { return (Program); }
Read        { return (Read); }
Then        { return (Then); }
Var         { return (Var); }
While       { return (While); }
Write       { return (Write); }
"+"         { return (Add); }
"-"         { return (Sub); }
"*"         { return (Mul); }
"/"         { return (Div); }
"%"         { return (Mod); }
"="         { return (Ass); }
"=="        { return (Eq); }
"<>"        { return (Neq); }
">"         { return (Gt); }
">="        { return (Gte); }
"<"         { return (Lt); }
"<="        { return (Lte); }
"("         { return (Lp); }
")"         { return (Rp); }
({letter}|{underscore})({letter}|{digit}|{underscore})* {  
    return (Id);
}
[0-9]+ {
    return (Constant);
}
. {
    fprintf(stderr, "Lexical error: line %d: unknown character %s\n", yylineno, yytext);
}

%%
