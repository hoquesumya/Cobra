%{
open Ast
%}

%token <int> LITERAL
%token <bool> BLIT
%token <string> ID
%token LPAREN RPAREN COLON COMMA DEF ENDEF ELSE IF ENDIF WHILE NEXT RETURN INT BOOL PLUS MINUS ASSIGN EQ NEQ LT GT LTE GTE EOF
%token BREAK CONTINUE DEREF POINTER MUL  ADDRESS_OF RETAIN

%nonassoc ELSE COLON
%right ASSIGN 
%left EQ NEQ
%left LT GT LTE GTE
%left PLUS MINUS
%left MUL
%right ADDRESS_OF
%right DEREF RETAIN

%nonassoc LPAREN
%nonassoc RPAREN

%start program_rule
%type <Ast.program> program_rule

%%

program_rule:
  | statements EOF { { locals = []; body = $1 } }

statements:
  | statement { [$1] }
  | statement statements { $1 :: $2 }

statement:
  | DEF ID LPAREN parameters RPAREN COLON statement_list ENDEF { Function ($2, $4, $7) }
  | IF expr COLON statement_list ELSE COLON statement_list ENDIF { If ($2, $4, Some($7)) }
  | IF expr COLON statement_list ENDIF { If ($2, $4, None) }
  | WHILE expr COLON statement_list NEXT { While ($2, $4) }
  | RETURN expr { Return $2 }
  | expr { Expr $1 }
  | BREAK {Break}
  | CONTINUE {Continue}


statement_list:
  | statement { [$1] }
  | statement statement_list { $1 :: $2 }

typ:
  | BOOL {Bool}
  | INT {Int}

Id_catg:
 ID { Id $1}
 | POINTER ID { PointerID $2}
expr:
  | LITERAL { Literal $1 }
  | BLIT { BoolLit $1 }
  | ID {Var $1}
  | expr PLUS expr { Binop ($1, Add, $3) }
  | expr MINUS expr { Binop ($1, Sub, $3) }
  | ID ASSIGN expr { Assign ($1, $3) }
  | typ Id_catg ASSIGN expr {AssignVar ($1, $2,$4)}
  | DEREF expr ASSIGN expr {AssignPointer ($2,$4)}
  | expr EQ expr { Binop ($1, Equal, $3) }
  | expr NEQ expr { Binop ($1, Neq, $3) }
  | expr MUL expr {Binop ($1, Mul, $3)}
  | expr LT expr { Binop ($1, Less, $3) }
  | expr GT expr { Binop ($1, Greater, $3) }
  | expr LTE expr { Binop ($1, LessEq, $3) }
  | expr GTE expr { Binop ($1, GreaterEq, $3) }
  | ID LPAREN args_opt RPAREN{ Call($1, $3) }
  | LPAREN expr RPAREN {$2}
  | DEREF expr {Memory_handler(Dref, $2)}
  | ADDRESS_OF expr {Memory_handler (Address_of, $2)}
  | RETAIN expr {Memory_handler (Retain, $2)}

args_opt:
  | { [] }
  | args { $1 }

args:
  | expr { [$1] }
  | expr COMMA args{ $1 :: $3 }

parameters:
  |  { [] }
  | parameter_list { $1 }

parameter_list:
  | ID { [$1] }
  | ID COMMA parameter_list { $1 :: $3 }
