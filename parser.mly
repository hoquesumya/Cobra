%{
open Ast
%}

%token <int> LITERAL
%token <bool> BLIT
%token RELEASE AUTORELEASE RETAIN
%token <string> ID
%token LPAREN RPAREN COLON COMMA DEF ENDEF ELSE IF ENDIF WHILE NEXT RETURN INT BOOL INTPTR BOOLPTR PLUS MINUS ASSIGN EQ NEQ LT GT LTE GTE EOF STAR DIV
%token AMP NEWLINE CLASS ENDCLASS DOT ARROW UNARY SEP


%start program_rule
%type <Ast.program> program_rule

%right ASSIGN
%left DOT
%left EQ NEQ 
%left LT LTE GT GTE
%left PLUS MINUS
%left STAR DIV
%right UNARY

%right AMP


%nonassoc LPAREN
%nonassoc RPAREN


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
  | CLASS ID LPAREN ID RPAREN COLON NEWLINE block ENDCLASS { ClassDecl {class_name = $2; superclass = Some $4; class_body = $8} }
  | CLASS ID COLON NEWLINE block ENDCLASS { ClassDecl {class_name = $2; superclass = None; class_body = $5} }
  | DEF ID parameters ARROW typ COLON NEWLINE block ENDEF { Function ($2, $3, Some($5), $8) }
  | DEF ID parameters COLON NEWLINE block ENDEF { Function ($2, $3, None, $6) }
  | IF expr COLON NEWLINE block ENDIF { If ($2, $5, None) }
  | IF expr COLON NEWLINE block ELSE COLON NEWLINE block ENDIF { If ($2, $5, Some($9)) }
  | WHILE expr COLON NEWLINE block NEXT { While ($2, $5) }
  | RETURN expr NEWLINE{ Return $2 }
  | expr NEWLINE{ Expr $1 }
  | typ ID {Decl(Some $1, $2)}



block:
  | statements { Block $1 }


typ:
  | INT { Int }
  | BOOL { Bool }
  | INTPTR { IntPtr }
  | BOOLPTR { BoolPtr }

expr:
  | LITERAL { Literal $1 }
  | BLIT { BoolLit $1 }
  | ID { Var $1 }
  | expr DOT ID args { ObjectCall($1, $3, $4) }
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
  | typ ID ASSIGN expr { Assign (Some $1, Var($2), $4) }
  | expr ASSIGN expr { Assign (None, $1, $3) }
  | LPAREN expr RPAREN { $2 }
  | MINUS expr %prec UNARY { Unop (Negate, $2) }
  | AMP expr %prec UNARY { Ref $2 }
  | STAR ID %prec UNARY { Deref(Var($2)) }
  | RELEASE LPAREN expr RPAREN { MemoryOp($3, Release) }
  | AUTORELEASE LPAREN expr RPAREN { MemoryOp($3, AutoRelease) }
  | RETAIN LPAREN expr RPAREN { MemoryOp($3, Retain) }
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
  | ID COLON typ { [{ param_type = Some($3); param_name = $1 }] }
  | ID COLON typ COMMA parameter_list { { param_type = Some($3); param_name = $1 } :: $5 }

  | ID { [{ param_type = None; param_name = $1 }] }
  | ID COMMA parameter_list { { param_type = None; param_name = $1 } :: $3 }
