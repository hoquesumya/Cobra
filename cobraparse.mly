%{
open Ast
%}

%token <int> LITERAL
%token <bool> BLIT
%token <string> ID
%token LPAREN RPAREN COLON COMMA DEF ENDEF ELSE IF ENDIF WHILE NEXT RETURN INT BOOL PLUS MINUS ASSIGN EQ NEQ LT GT LTE GTE EOF
%token BREAK CONTINUE DEREF POINTER MUL  ADDRESS_OF RETAIN CLASS ENDCLS

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
  | expr {$1}
  


statement_list:
  | statement { [$1] }
  | statement statement_list { $1 :: $2 }

expr:
  | LITERAL { Literal $1 }
  | BLIT { BoolLit $1 }
  | ID {Var $1}
  | ID LPAREN args_opt RPAREN {Call($1, $3)}
  | expr PLUS expr { Binop ($1, Add, $3) }
  | expr MINUS expr { Binop ($1, Sub, $3) }
  | ID ASSIGN expr { Assign ($1, $3) }
  | LPAREN expr RPAREN {$2} 

  

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
