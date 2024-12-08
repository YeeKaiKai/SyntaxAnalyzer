%{
    #include <stdio.h>
    #include <stdlib.h>
    #include <getopt.h>

    extern int yylineno;
    int verbose = 0;

    void yyerror(const char *s) {
        fprintf(stderr, "Syntax error: line %d\n", yylineno);
    }
%}
%token And Begin Do Else End EndIf EndWhile Exit If Set Not Or Program Read Then Var While Write Add Sub Mul Div Mod Ass Eq Neq Gt Gte Lt Lte Lp Rp Id Constant
%nonassoc Eq Neq Gt Gte Lt Lte
%left Add Sub
%left Mul Div Mop
%right UMINUS
%%
program : Program Begin declarations statements End {if (verbose) printf("program -> Program Begin declarations statements End\n");}
declarations : declarations Var Id {if (verbose) printf("declarations -> declarations Var Identifier\n");}
	     | {if (verbose) printf("declarations -> <empty>\n");}
statements : statements statement {if (verbose) printf("statements -> statements statement\n");}
	   | {if (verbose) printf("statements -> <empty>\n");}
statement : Set Id Ass arithExpr {if (verbose) printf("statement -> Set Identifier = arithExpr\n");}
	  | If boolExpr Then statements EndIf {if (verbose) printf("statement -> If boolExpr Then statements EndIf\n");}
          | If boolExpr Then statements Else statements EndIf {if (verbose) printf("statement -> If boolExpr Then statements Else statements EndIf\n");}
	  | While boolExpr Do statements EndWhile {if (verbose) printf("statement -> While boolExpr Do statements EndWhile\n");}
	  | Read Id {if (verbose) printf("statement -> Read Identifier\n");}
	  | Write arithExpr {if (verbose) printf("statement -> Write arithExpr\n");}
	  | Exit {if (verbose) printf("statement -> Exit\n");}
boolExpr : boolExpr Or boolTerm {if (verbose) printf("boolExpr -> boolExpr Or boolTerm\n");}
	 | boolTerm {if (verbose) printf("boolExpr -> boolTerm\n");}
boolTerm : boolTerm And boolFactor {if (verbose) printf("boolTerm -> boolTerm And boolFactor\n");}
	 | boolFactor {if (verbose) printf("boolTerm -> boolFactor\n");}
boolFactor : Not boolFactor {if (verbose) printf("boolFactor -> Not boolFactor\n");}
	   | relExpr {if (verbose) printf("boolFactor -> relExpr\n");}
relExpr : arithExpr Eq arithExpr {if (verbose) printf("relExpr -> arithExpr == arithExpr\n");}
	| arithExpr Neq arithExpr {if (verbose) printf("relExpr -> arithExpr <> arithExpr\n");}
	| arithExpr Gt arithExpr {if (verbose) printf("relExpr -> arithExpr > arithExpr\n");}
	| arithExpr Gte arithExpr {if (verbose) printf("relExpr -> arithExpr >= arithExpr\n");}
	| arithExpr Lt arithExpr {if (verbose) printf("relExpr -> arithExpr < arithExpr\n");}
	| arithExpr Lte arithExpr {if (verbose) printf("relExpr -> arithExpr <= arithExpr\n");}
arithExpr : arithExpr Add arithTerm {if (verbose) printf("arithExpr -> arithExpr + arithTerm\n");}
	  | arithExpr Sub arithTerm {if (verbose) printf("arithExpr -> arithExpr - arithTerm\n");}
 	  | arithTerm {if (verbose) printf("arithExpr -> arithTerm\n");}
arithTerm : arithTerm Mul arithFactor {if (verbose) printf("arithTerm -> arithTerm * arithFactor\n");}
 	  | arithTerm Div arithFactor {if (verbose) printf("arithTerm -> arithTerm / arithFactor\n");}
 	  | arithTerm Mod arithFactor {if (verbose) printf("arithTerm -> arithTerm % arithFactor\n");}
 	  | arithFactor {if (verbose) printf("arithTerm -> arithFactor\n");}
arithFactor : Sub arithFactor %prec UMINUS {if (verbose) printf("arithFactor -> - arithFactor\n");}
	    | primExpr {if (verbose) printf("arithFactor -> primExpr\n");}
primExpr : Constant {if (verbose) printf("primExpr -> IntConst\n");}
	 | Id {if (verbose) printf("primExpr -> Identifier\n");}
	 | Lp arithExpr Rp {if (verbose) printf("primExpr -> ( arithExpr )\n");}
%%

int main(int argc, char* argv[]) {

    int opt = 0;
    while ((opt = getopt(argc, argv, "p")) != -1) {
        switch (opt) {
            case 'p':
                verbose = 1;
                break;
            default:
                fprintf(stderr, "Usage: %s [-s]\n", argv[0]);
                exit(EXIT_FAILURE);
        }
    }

    yyparse();

    return 0;
}
