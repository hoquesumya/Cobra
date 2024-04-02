%{ open Ast %}

%token PLUS MINUS TIMES DIVIDE ASN SEQ EOF
%token <int> LITERAL
%token <string> VARIABLE

%right ASN
%left PLUS MINUS
%left TIMES DIVIDE

%start expr
%type <Ast.expr> expr

%%

expr:
  expr SEQ expr { Seq($1, $3) }
| assign_expr { $1 }

assign_expr:
  VARIABLE ASN assign_expr { Asn($1, $3) }
| assign_expr PLUS assign_expr { Binop($1, Add, $3) }
| assign_expr MINUS assign_expr { Binop($1, Sub, $3) }
| assign_expr TIMES assign_expr { Binop($1, Mul, $3) }
| assign_expr DIVIDE assign_expr { Binop($1, Div, $3) }
| LITERAL { Lit($1) }
| VARIABLE { Var($1) }
