/* Ocamlyacc parser for MicroC */

%{
open Ast
%}

%token <int> LITERAL
%token <bool> BLIT
%token <string> ID
%token LPAREN RPAREN COLON COMMA DEF ENDEF ELSE IF ENDIF WHILE NEXT RETURN INT BOOL PLUS MINUS ASSIGN EQ NEQ LT GT LTE GTE EOF
%token BREAK CONTINUE DEREF POINTER MUL  ADDRESS_OF CLASS ENDCLS DOT RELEASE  SEMI COLON_D MAKEMAN
%token RETAIN


%start program_rule
%type <Ast.program> program_rule

%right ASSIGN
%left DOT
%left EQ NEQ
%left LT GT LTE GTE
%left PLUS MINUS
%right DEREF RETAIN

%right ADDRESS_OF
%nonassoc LPAREN
%nonassoc RPAREN

%%

/* add function declarations*/
program_rule:
  statements EOF { { locals = []; body = $1 } }

statements:
  /* nothing */ { [] }
  | statement statements  { $1::$2 }

statement: 
    expr  SEMI                                                { Expr $1      }
  | CLASS ID LPAREN parameters RPAREN COLON statements ENDCLS {Class ($2,$4,$7)}
  | DEF ID LPAREN parameters RPAREN COLON statements ENDEF { Function ($2, $4, $7) }
  | IF expr COLON statements ELSE COLON statements ENDIF { If ($2, $4, Some($7)) }
  | IF expr COLON statements ENDIF      { If ($2, $4, None) }
  | WHILE expr COLON statements NEXT      { While ($2, $4) }
  | RETURN expr  SEMI                    { Return $2      }
  | BREAK SEMI                            {Break}
  | CONTINUE SEMI                         {Continue}
  | RELEASE ID SEMI                      {Memory_ref (Release,$2)}
  | MAKEMAN ID SEMI                      {Memory_ref (Makeman,$2)}


Id_catg:
ID { Id $1}
 | POINTER ID { PointerID $2}

typ:
  | BOOL {Bool}
  | INT {Int}

expr:
    LITERAL          { Literal($1)            }
  | BLIT             { BoolLit($1)            }
  | ID               { Var $1                 }
  | expr PLUS   expr { Binop($1, Add,   $3)   }
  | expr MINUS  expr { Binop($1, Sub,   $3)   }
  | expr EQ     expr { Binop($1, Equal, $3)   }
  | expr NEQ    expr { Binop($1, Neq, $3)     }
  | expr LT     expr { Binop($1, Less,  $3)   }
  | expr GT     expr  { Binop ($1, Greater, $3)}
  | expr LTE    expr { Binop ($1, LessEq, $3) }
  | expr GTE    expr { Binop ($1, GreaterEq, $3) }
  | ID ASSIGN   expr   { Assign($1, $3)         }
  | typ Id_catg ASSIGN expr {AssignVar ($1, $2,$4)}
  | DEREF expr1 ASSIGN expr {AssignPointer(Dref,$2,$4)}
  | ID COLON_D ID ASSIGN expr { Init_class($1, $3, $5) }
  | LPAREN expr RPAREN { $2                   }
  | expr DOT ID LPAREN args_opt RPAREN {Method ($1, $3, $5)}
  | ID LPAREN args_opt RPAREN { Call ($1, $3)  }
  | DEREF expr1 {Memory_handler(Dref, $2)}
  | ADDRESS_OF expr {Memory_handler' (Address_of, $2)}
  | RETAIN expr { print_endline "reatin"; Memory_handler' (Retain, $2)}


expr1:
   | ID                  { print_endline $1 ;Var1($1)}
   | LITERAL             { Literal1($1)              }
   | expr1 PLUS   expr1  { Binop1($1, Add,   $3)     }
   | expr1 MINUS  expr1  { Binop1($1, Sub,   $3)     }
   | LPAREN expr1 RPAREN { $2                        }
   | DEREF expr1         { Memory_handler1(Dref, $2) }


/* args_opt*/
args_opt:
  /*nothing*/ { [] }
  | args { $1 }

args:
  expr  { [$1] }
  | expr COMMA args { $1::$3 }

parameters:
  |  { [] }
  | parameter_list { $1 }

parameter_list:
  | ID { [$1] }
  | ID COMMA parameter_list { $1 :: $3 }
