%{
open Ast
%}

%token <int> INT
%token <string> ID
%token DEF IF ELSE PRINT
%token LPAREN RPAREN COMMA LBRACE RBRACE EOF

%start <Ast.program> program

%type <Ast.stmt list> stmt_list
%type <Ast.expr> expr
%type <Ast.stmt> stmt

%%

program:
  | stmt_list EOF { $1 }

stmt_list:
  | /* empty */ { [] }
  | stmt stmt_list { $1 :: $2 }

stmt:
  | expr ';' { Expr $1 }
  | PRINT '(' expr ')' ';' { Print $3 }
  | IF '(' expr ')' LBRACE stmt_list RBRACE ELSE LBRACE stmt_list RBRACE {
      If($3, $6, $10) }
  | DEF ID '(' param_list ')' LBRACE stmt_list RBRACE {
      FunctionDef($2, $4, $7) }

expr:
  | INT { Int $1 }
  | ID { Var $1 }
  | ID '(' arg_list ')' { FunctionCall($1, $3) }

param_list:
  | /* empty */ { [] }
  | ID { [$1] }
  | ID ',' param_list { $1 :: $3 }

arg_list:
  | /* empty */ { [] }
  | expr { [$1] }
  | expr ',' arg_list { $1 :: $3 }
