%{
open Ast
%}

%token <int> LITERAL
%token <bool> BLIT
%token <string> ID
%token LPAREN RPAREN COLON COMMA DEF ELSE IF WHILE RETURN INT BOOL PLUS MINUS ASSIGN EQ NEQ LT GT INDENT DEDENT EOF

%start program_rule
%type <Ast.program> program_rule

%%

program_rule:
  | statements EOF { { locals = []; body = $1 } }  (* Simplified structure *)

statements:
  | statement { print_endline "PARSER STATEMENT"; [$1] }
  | statement statements { print_endline "PARSER STATEMENT"; $1 :: $2 }

statement:
  | DEF ID parameters COLON block { Function ($2, $3, $5) }
  | expr { Expr $1 }
  | IF expr COLON block            { print_endline "PARSER IF"; If ($2, $4, None) }
  // | IF expr COLON block ELSE COLON block { If ($2, $4, Some($7)) }
  | WHILE expr COLON block { While ($2, $4) }
  | RETURN expr { Return $2 }

block:
  | INDENT statements DEDENT { print_endline "PARSER BLOCK"; $2 }

expr:
  | LITERAL { Literal $1 }
  | BLIT { BoolLit $1 }
  | ID { Var $1 }
  | expr PLUS expr { Binop ($1, Add, $3) }
  | expr MINUS expr { Binop ($1, Sub, $3) }
  | expr ASSIGN expr { print_endline "PARSER ASSIGN"; Assign ($1, $3) }
  | expr EQ expr { Binop ($1, Equal, $3) }
  | expr NEQ expr { Binop ($1, Neq, $3) }
  | expr LT expr { Binop ($1, Less, $3) }
  | expr GT expr { Binop ($1, Greater, $3) }

parameters:
  | LPAREN RPAREN { [] }
  | LPAREN parameter_list RPAREN { $2 }

parameter_list:
  | ID { [$1] }
  | ID COMMA parameter_list { $1 :: $3 }
