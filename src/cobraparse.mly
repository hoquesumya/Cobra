%{ 
	open Ast
%}


%token NOELSE ASN EQ NEQ LT GT LEQ GEQ PLUS MINUS TIMES DIVIDE PLUSEQ MINUSEQ TIMESEQ DIVIDEEQ EXPEQ
%token EXP AND OR ARROW CONTINUE BREAK
%token TAB SPACE COLON EOF EOL IF ELSE ELIF FOR WHILE COMMA DEF IN  RETURN NONE DOT
%token BOOL INT FLOAT STRING TUPLE LIST MODULUS
%token CLASS IMPORT RANGE
%token INDENT DEDENT NEW DREF PUBLIC PRIVATE ADDRESS_OF
%token LPAREN RPAREN
%token LBRACK RBRACK VIRTUAL NULL MAKEMANUAL RELEASE
%token LBRACE RBRACE
%token <string> VARIABLE

%token <float> Float_Lit
%token <string> String_Lit 
%token <int> Literal
%token <bool> BLIT


%nonassoc NOELSE /* handles shift-reduce error for else and noelse clauses */
%nonassoc ELSE

%right ASN PLUSEQ MINUSEQ DIVIDEEQ TIMESEQ
%left DOT NEW
%left OR
%left AND 
%left EQ NEQ
%left LT GT LEQ GEQ
%left PLUS MINUS
%left TIMES DIVIDE MODULUS
%right EXP
%right ADDRESS_OF
%right DEREF 
%left EOL

%nonassoc LPAREN LBRACK LBRACE
%nonassoc RPAREN RBRACK RBRACE



%start program
%type <Ast.stmt> program

%%


program: stmt_list EOF { {body=$1} }

stmt_list:
  | { [] }
  | stmt stmt_list { $1 :: $2 }


stmt:
  | expr_rule EOL expr_rule{ Expr ($1,$3) }
  | compound_stmts {$1}
  | RETURN expr_rule EOL { Return $2 }
  | complex_assignments {$1}
  | BREAK EOL { Break }
  | CONTINUE EOL { Continue }
  | IMPORT expr_rule EOL { Import($2)}

 elif_block_list:
 | (*nothing*) {[]}
 | elif_block elif_block_list {$1::$2}

 elif_block:
 | ELIF expr_rule COLON EOL stmt_block_list {elif($2,$5)}

  compound_stmts:
  | for_stmt {$1}
  | class_stmt {$1}
  |func_stmt {$1}
  | while_rule {$1}
  | if_stmt {$1}

if_stmt:
  | IF expr_rule COLON EOL stmt_block_list %prec NOELSE {{if ($2,$5,$Block([])])} }
  | IF expr_rule COLON EOL stmt_block_list elif_block_list ELSE COLON EOL stmt_block_list {ifElif($2,$5,Elif($6),$10)}

while_rule:
 WHILE expr_rule COLON EOL stmt_block_list { While($2, $5) }

for_stmt:
 | FOR bind_variable IN expr_rule COLON EOL stmt_block_list {For($2,$4,$7)}
 | FOR bind_variable IN RANGE LPAREN expr_rule RPAREN COLON EOL stmt_block_list {Range ($2, $6, $10)}

class_stmt:
  | CLASS VARIABLE LPAREN list_parameter_list RPAREN COLON EOL stmt_block_list {Class ($2,$4,$8) }
  | VIRTUAL CLASS VARIABLE COLON EOL stmt_block_list { Virtual_Class($3,$6) }
  | PUBLIC COLON EOL stmt_block_list {Public ($4)}
  | PRIVATE COLON EOL stmt_block_list {Private ($4)}

(*to do *)
func_stmt:
  | DEF VARIABLE LPAREN  list_parameter_list RPAREN COLON EOL stmt_block_list { Func(Bind($2, Dyn), $4, $8) }
  | DEF VARIABLE LPAREN  list_parameter_list RPAREN ARROW typ COLON EOL stmt_block_list { Func(Bind($2, $7), $4, $10) }
  | VIRTUAL DEF VARIABLE LPAREN  list_parameter_list RPAREN {Virtual_fun(Bind($3,Dynamic),$5)}
  

complex_assignments:
  | formal_asn_list ASN expr_rule { Asn(List.rev $1, $3) }
  | lvalue PLUSEQ expr_rule{ Asn([$1], Binop($1, Add, $3)) }
  | lvalue MINUSEQ expr_rule { Asn([$1], Binop($1, Sub, $3)) }
  | lvalue TIMESEQ expr_rule { Asn([$1], Binop($1, Mul, $3)) }
  | lvalue DIVIDEEQ expr_rule { Asn([$1], Binop($1, Div, $3)) }

formal_asn_list:
  | lvalue { [$1] }
  | formal_asn_list ASN lvalue { $3 :: $1 }

lvalue:
  | bind_variable { Var $1 }
  | list_access { $1 }

 (*dynamic binding*)

bind_variable:
  | VARIABLE { Bind($1, Dyn) }
  | VARIABLE COLON typ { Bind($1, $3) }
  | VARIABLE COLON typ LBRACK RBRACK { Bind($1, $3)} (*Cstyle array*)


list_access:
  | expr_rule LBRACK expr_rule RBRACK { ListAccess($1, $3) }


stmt_block_list: 
  | INDENT stmt_list DEDENT { Block($2) }


 list_parameter_list:
  | { [] }
  | opt_list {  $1 }


opt_list: 
  | bind_variable { [$1] }
  | bind_variable COMMA opt_list { $1 :: $3 }


 list_argument:
|(*nothing*) {[]}
| list_of_arg {$1}
list_of_arg:
 | expr_rule {[$1]}
 | expr_rule COMMA list_of_arg{$1::$3}


typ:
  | FLOAT { Float }
  | INT { Int }
  | BOOL { Bool }
  | STRING { String }
  | TUPLE {Tuple}
  | LIST {List}


expr_rule:
| list_access { $1 }
| VARIABLE {{Bind($1,Dynamic)} }
| expr_rule LPAREN list_argument RPAREN { Func_call($1,$3)}
| expr_rule DOT VARIABLE LPAREN list_argument RPAREN {Class_Method ($1, $3, $5)}
| LPAREN expr_rule RPAREN { $2 }
| all_lit {$1}
| LBRACK list_argument RBRACK { List($2) }  (*list*)
| LPAREN list_argument RBRACK { Tuple($2)} (*Tuple*)
| all_simple_assignment {$1}
| DEREF expr_rule {Memory_manage (Deref, $2)} 
| NEW expr_rule {Memory_manage (New, $2)}
| ADDRESS_OF expr_rule {Memory_manage (Address, $2)}
| MAKEMANUAL VARIABLE {Memory_REF(Makemanual, (Bind($2,Dynamic)))}
| RELEASE VARIABLE {Memory_REF(Makemanual, (Bind($2,Dynamic)))}

all_simple_assignment:
| expr_rule EQ expr_rule { Binop($1, Eq, $3) }
| expr_rule NEQ expr_rule { Binop($1, Neq, $3) }
| expr_rule LT expr_rule { Binop($1, Less, $3) }
| expr_rule GT expr_rule { Binop($1, Greater, $3) }
| expr_rule LEQ expr_rule { Binop($1, Leq, $3) }
| expr_rule GEQ expr_rule { Binop($1, Geq, $3) }
| expr_rule AND expr_rule { Binop($1, And, $3) }
| expr_rule OR expr_rule { Binop($1, Or, $3) }
| expr_rule PLUS expr_rule { Binop($1, Add, $3) }
| expr_rule MINUS expr_rule { Binop($1, Sub, $3) }
| expr_rule TIMES expr_rule { Binop($1, Mul, $3) }
| expr_rule DIVIDE expr_rule { Binop($1, Div, $3) }
| expr_rule EXP expr_rule { Binop($1, Exp, $3) }
| expr_rule MODULUS expr_rule  { Binop($1, Mod, $3) }


all_lit:
| Float_Lit {Float_literal ($1)}
| BLIT {Bool $1}
| Literal {Literal($1)} 
| String_Lit  { Stirng_literal ($1)} 

;;
