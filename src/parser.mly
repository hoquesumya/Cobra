%{ open Ast %}

%token LPAREN RPAREN
%token PLUS MINUS TIMES DIVIDE ASN SEQ EOF
%token AND OR NOT EQ NEQ
%token <int> LITERAL
%token <bool> TRUE FALSE
%token <string> VARIABLE

%right ASN
%left PLUS MINUS
%left TIMES DIVIDE
%left AND OR

%start expr_root
%type <Ast.expr> expr_root

%%

expr_root:
  expr_root SEQ expr_root { Seq($1, $3) }
| expr { $1 }

expr:
  VARIABLE ASN expr { Asn($1, $3) }
| expr PLUS expr { Binop($1, Add, $3) }
| expr MINUS expr { Binop($1, Sub, $3) }
| expr TIMES expr { Binop($1, Mul, $3) }
| expr DIVIDE expr { Binop($1, Div, $3) }
| LITERAL { Lit($1) }
| TRUE { BoolLit(true) }
| FALSE { BoolLit(false) }
| expr EQ expr { Eq($1, $3) }
| expr NEQ expr { Neq($1, $3) }
| expr AND expr { And($1, $3) }
| expr OR expr { Or($1, $3) }
| NOT expr { Not($2) }
| VARIABLE { Var($1) }
| LPAREN expr RPAREN { $2 }
