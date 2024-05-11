%{
open Ast
%}

%token <int> LITERAL
%token <bool> BLIT
%token <string> ID
%token LPAREN RPAREN COLON COMMA DEF ENDEF ELSE IF ENDIF WHILE NEXT RETURN INT BOOL INTPTR BOOLPTR PLUS MINUS ASSIGN EQ NEQ LT GT LTE GTE EOF STAR DIV AMP NEWLINE

%right ASSIGN
%right UNARY
%left EQ NEQ LT LTE GT GTE
%left PLUS MINUS
%left STAR DIV
%nonassoc UNARY

%start program_rule
%type <Ast.program> program_rule

%%

program_rule:
  | statements EOF { { locals = []; body = Block $1 } }

statements:
  | statement_newline { [$1] }
  | statement_newline statements { $1 :: $2 }

statement_newline:
  | statement { $1 }
  | statement NEWLINE { $1 }

statement:
  | DEF ID parameters COLON NEWLINE block ENDEF { Function ($2, $3, $6) }
  | IF expr COLON NEWLINE block ENDIF { If ($2, $5, None) }
  | IF expr COLON NEWLINE block ELSE COLON NEWLINE block ENDIF { If ($2, $5, Some($9)) }
  | WHILE expr COLON NEWLINE block NEXT { While ($2, $5) }
  | RETURN expr { Return $2 }
  | expr { Expr $1 }
  | opt_typ ID { Decl($1, $2) }

block:
  | statement_list { Block $1 }

statement_list:
  | statement_newline { [$1] }
  | statement_newline statement_list { $1 :: $2 }

opt_typ:
  | typ { Some $1 }
  | { None }

typ:
  | INT { Int }
  | BOOL { Bool }
  | INTPTR { IntPtr }
  | BOOLPTR { BoolPtr }

expr:
  | LITERAL { Literal $1 }
  | BLIT { BoolLit $1 }
  | ID { Var $1 }
  | expr PLUS expr { Binop ($1, Add, $3) }
  | expr MINUS expr { Binop ($1, Sub, $3) }
  | expr STAR expr { Binop ($1, Mult, $3) }
  | expr DIV expr { Binop ($1, Div, $3) }
  | expr EQ expr { Binop ($1, Equal, $3) }
  | expr NEQ expr { Binop ($1, Neq, $3) }
  | expr LT expr { Binop ($1, Less, $3) }
  | expr LTE expr { Binop ($1, LessEq, $3) }
  | expr GT expr { Binop ($1, Greater, $3) }
  | expr GTE expr { Binop ($1, GreaterEq, $3) }
  | ID ASSIGN expr { Assign (None, Var($1), $3) }
  | opt_typ ID ASSIGN expr { Assign ($1, Var($2), $4) }
  | expr ASSIGN expr { Assign (None, $1, $3) }
  | LPAREN expr RPAREN { $2 }
  | MINUS expr %prec UNARY { Unop (Negate, $2) }
  | AMP expr %prec UNARY { Ref $2 }
  | STAR ID %prec UNARY { Deref(Var($2)) }
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
  | opt_typ ID { [{ param_type = $1; param_name = $2 }] }
  | opt_typ ID COMMA parameter_list { { param_type = $1; param_name = $2 } :: $4 }
