%{
  open Ast
%}

%token DEF LBRACE RBRACE LPAREN RPAREN COMMA RETURN ASN SEQ EOF
%token PLUS MINUS TIMES DIVIDE AND OR
%token <int> LITERAL
%token <bool> TRUE FALSE
%token <string> IDENTIFIER

%right ASN
%left PLUS MINUS
%left TIMES DIVIDE
%left AND OR

%start expr_root
%type <Ast.expr> expr_root

%%

expr_root:
  statements EOF { $1 }

statements:
  statement { $1 }
| statement SEQ statements { Seq($1, $3) }

statement:
  expr { $1 }

expr:
  DEF IDENTIFIER LPAREN opt_params RPAREN expr { FunDef($2, $4, $6) }
| IDENTIFIER LPAREN opt_args RPAREN { FunCall($1, $3) }
| expr PLUS expr { Binop($1, Add, $3) }
| expr MINUS expr { Binop($1, Sub, $3) }
| expr TIMES expr { Binop($1, Mul, $3) }
| expr DIVIDE expr { Binop($1, Div, $3) }
| expr AND expr { And($1, $3) }
| expr OR expr { Or($1, $3) }
| IDENTIFIER ASN expr { Asn($1, $3) }
| LITERAL { Lit($1) }
| TRUE { BoolLit(true) }
| FALSE { BoolLit(false) }
| IDENTIFIER { Var($1) }
| LPAREN expr RPAREN { $2 }
| RETURN expr { Return $2 }

opt_params:
  /* Empty */ { [] }
| params { $1 }

params:
  IDENTIFIER { [Var($1)] }
| IDENTIFIER COMMA params { Var($1) :: $3 }

opt_args:
  /* Empty */ { [] }
| args { $1 }

args:
  expr { [$1] }
| expr COMMA args { $1 :: $3 }
