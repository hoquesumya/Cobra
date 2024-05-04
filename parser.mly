%{
open Ast
%}

%token <int> LITERAL
%token <bool> BLIT
%token <string> ID
%token LPAREN RPAREN COLON COMMA DEF ENDEF ELSE IF ENDIF WHILE NEXT RETURN INT BOOL PLUS MINUS ASSIGN EQ NEQ LT GT LTE GTE EOF STAR DIV

%start program_rule
%type <Ast.program> program_rule

%%

program_rule:
  | statements EOF { { locals = []; body = Block $1 } }

statements:
  | statement { [$1] }
  | statement statements { $1 :: $2 }

statement:
  | DEF ID parameters COLON block ENDEF { Function ($2, $3, $5) }
  | IF expr COLON block ENDIF { If ($2, $4, None) }
  | IF expr COLON block ELSE COLON block ENDIF { If ($2, $4, Some($7)) }
  | WHILE expr COLON block NEXT { While ($2, $4) }
  | RETURN expr { Return $2 }
  | expr { Expr $1 }

block:
  | statement_list { Block $1 }  // Construct Block here

statement_list:
  | statement { [$1] }
  | statement statement_list { $1 :: $2 }

expr:
  | LITERAL { Literal $1 }
  | BLIT { BoolLit $1 }
  | ID { Var $1 }
  | expr PLUS expr { Binop ($1, Add, $3) }
  | expr MINUS expr { Binop ($1, Sub, $3) }
  | expr STAR expr { Binop ($1, Mult, $3) }
  | expr DIV expr { Binop ($1, Div, $3) }
  | ID ASSIGN expr { Assign ($1, $3) }
  | expr EQ expr { Binop ($1, Equal, $3) }
  | expr NEQ expr { Binop ($1, Neq, $3) }
  | expr LT expr { Binop ($1, Less, $3) }
  | expr GT expr { Binop ($1, Greater, $3) }
  | expr LTE expr { Binop ($1, LessEq, $3) }
  | expr GTE expr { Binop ($1, GreaterEq, $3) }
  | ID args { Call($1, $2) }

args:
  | LPAREN RPAREN { [] }
  | LPAREN arg_list RPAREN { $2 }

arg_list:
  | expr { [$1] }
  | expr COMMA arg_list { $1 :: $3 }

parameters:
  | LPAREN RPAREN { [] }
  | LPAREN parameter_list RPAREN { $2 }

parameter_list:
  | ID { [$1] }
  | ID COMMA parameter_list { $1 :: $3 }
