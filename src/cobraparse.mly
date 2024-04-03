%{ 
	open Ast
%}


%token NOELSE ASN EQ NEQ LT GT LEQ GEQ PLUS MINUS TIMES DIVIDE PLUSEQ MINUSEQ TIMESEQ DIVIDEEQ EXPEQ
%token EXP AND OR ARROW CONTINUE BREAK
%token TAB SPACE COLON  IF ELSE ELIF FOR WHILE COMMA DEF IN  RETURN NONE DOT UNION
%token BOOL INT FLOAT STRING TUPLE LIST MODULUS  SEP
%token CLASS IMPORT RANGE DELETE TYPE
%token INDENT DEDENT NEW DREF PUBLIC PRIVATE ADDRESS_OF
%token LPAREN RPAREN
%token LBRACK RBRACK VIRTUAL NULL MAKEMANUAL RELEASE
%token LBRACE RBRACE RETAIN
%token <string> VARIABLE


%token <float> Float_Lit
%token <string> String_Lit 
%token <int> Literal
%token <bool> BLIT

%token EOF
%token EOL

%nonassoc NOELSE /* handles shift-reduce error for else and noelse clauses */
%nonassoc ELSE
%right ASN PLUSEQ MINUSEQ DIVIDEEQ TIMESEQ
%left DOT NEW DELETE
%left OR
%left AND 
%left EQ NEQ
%left LT GT LEQ GEQ
%left PLUS MINUS
%left TIMES DIVIDE MODULUS
%right EXP
%right ADDRESS_OF
%right DEREF RETAIN



%nonassoc LPAREN LBRACK LBRACE
%nonassoc RPAREN RBRACK RBRACE

%start program
%type <Ast.program> program

%%

program: 
| func_def_list EOF {$1} 

func_def_list:
 | {[]}
 | func_def func_def_list {$1::$2}

func_def:
  | DEF VARIABLE LPAREN list_parameter_list RPAREN COLON EOL INDENT stmt_list DEDENT 
  {
    Func_dynamic {
      fname = $2;
      formals = $4;
      body = $9;
    } 
  }
  | DEF VARIABLE LPAREN  list_parameter_list RPAREN ARROW typ COLON EOL stmt_block_list 
  {  
    Func_def_typ {
      rtype = $7;
      fname = $2;
      formals = $4;
      body = $10;
    }
  }
  (*| VIRTUAL DEF VARIABLE LPAREN  list_parameter_list RPAREN {Virtual_fun(Bind($3,Dynamic),$5)}*)


 list_parameter_list:
  | { [] }
  | opt_list {  $1 }


opt_list: 
  | bind_variable { [$1] }
  | bind_variable COMMA opt_list { $1 :: $3 }

bind_variable:
  | VARIABLE { Bind($1, Dynamic) }
  | VARIABLE COLON typ { Bind($1, $3) }


/*program: 
|stmt_list { {body=$1} }*/

stmt_list:
  | { [] }
  | stmt stmt_list { $1 :: $2 }
  
stmt:
  | expr EOL { Expr $1 }
  | MAKEMANUAL VARIABLE EOL {Memory_REF(Makemanual, $2)}
  | RELEASE VARIABLE EOL {Memory_REF(Release, $2)}
  | DELETE VARIABLE EOL {Memory_manage1(Delete,$2)}
  | DELETE LBRACK RBRACK VARIABLE EOL {Memory_manage1(Delete,$4)}
  | compund_stmt {$1}
  | RETURN expr  EOL {Return $2}


compund_stmt:
  | if_stmt {$1}
  | while_rule {$1}


stmt_block_list:
 INDENT stmt_list  DEDENT { $2}


(*starting of the grammer rule of while block*)
while_rule:
 WHILE expr COLON EOL while_stmt_block_list {While($2, $5) }


while_stmt_block_list: 
  | INDENT while_stmt_list DEDENT { While_Block($2) }

 while_stmt_list:
 {[]}
 | while_stmt while_stmt_list {$1::$2}

while_stmt:
  | expr EOL { Expr_while  $1 }
  | if_stmt_while {$1}
  | while_rule  {While_stmt $1}
  | MAKEMANUAL VARIABLE {While_Memory_REF(Makemanual, $2)}
  | RELEASE VARIABLE {While_Memory_REF(Release, $2)}
  | DELETE VARIABLE {While_Memory_manage1(Delete,$2)}
  | DELETE LBRACK RBRACK VARIABLE {While_Memory_manage1(Delete,$4)}
  | BREAK {Break}
  | CONTINUE{Continue}

if_stmt_while:
 | IF expr COLON EOL while_stmt_block_list %prec NOELSE { While_if ($2,$5,While_Block([]))} 
 | IF expr COLON EOL while_stmt_block_list elif_block_list_while ELSE COLON EOL while_stmt_block_list {While_ifElif($2,$5,$6,$10)}

 elif_block_list_while:
 | (*nothing*) {[]}
 | elif_block_while elif_block_list_while {$1::$2}

 elif_block_while:
 | ELIF expr COLON EOL while_stmt_block_list {While_elif($2,$5)}


(*end of the while rule*)

(*starting of regular if stmt *)

if_stmt:
  IF expr COLON EOL stmt_block_list %prec NOELSE {If ($2,$5,Block([]))} 
  | IF expr COLON EOL stmt_block_list elif_block_list ELSE COLON EOL stmt_block_list {IfElif ($2,$5,$6,$10)}



elif_block_list:
 | (*nothing*) {[]}
 | elif_block elif_block_list {$1::$2}

 elif_block:
 | ELIF expr COLON EOL stmt_block_list {Elif'($2,$5)}


(*end of the regular if stmt; can be used inside the function not a loop*)

 typ_list:
 | typ {[$1]}
 | typ UNION typ_list {$1::$3}


typ:
  | FLOAT { Float }
  | INT { Int }
  | BOOL { Bool }
  | STRING { String }
  | TUPLE {Tuple}
  | LIST {List}
  (*| NONE {None}*)

(*all_dot_ops:
VARIABLE DOT VARIABLE {$1::$3}
| all_dot_ops DOT VARIABLE {$1::$3}*)

  array_element:
 |(*nothing*) {[]}
 | array_arg {$1}

array_arg:
 | expr {[$1]}
 | expr COMMA array_arg{$1::$3}

all_Dref:
 VARIABLE {Id $1}
(*| all_dot_ops {Dot $1}*)
| LPAREN all_Dref RPAREN {$2}


all_new_op:
typ {Type $1}
| typ LBRACK Literal RBRACK {Arr_cons($1,Literal($3))}
| typ LBRACK VARIABLE RBRACK {Arr_Var($1,$3)}
| VARIABLE {Var $1}
| VARIABLE LBRACK Literal RBRACK  {Arr_Var_var($1,Literal($3))}
| VARIABLE LBRACK VARIABLE RBRACK  {Arr_Var_Const($1,$3)}



lvalue:
VARIABLE  {Bind($1,Dynamic)}
| VARIABLE COLON typ {Bind($1,$3)}
(*| DREF all_Dref      {Memory_manage(Deref, All_Dref $2)}*)

expr:
| VARIABLE {Variable(Bind($1,Dynamic))} 
| VARIABLE COLON typ {Variable(Bind($1,$3))} 
| all_simple_assignment {$1}
| LPAREN expr RPAREN {$2}
| VARIABLE LPAREN args_opt RPAREN { Func_call ($1, $3)  }
| VARIABLE DOT VARIABLE LPAREN args_opt RPAREN {Class_Method ($1, $3,$5)}
(*| all_dot_ops { Dot_ops $1}*)
| DEREF  all_Dref {Memory_manage (Dref, All_Dref $2)} 
| NEW all_new_op {Memory_manage (New, All_new_ops $2)}
| ADDRESS_OF expr {Memory_manage (Address, Expr' $2)}
| lvalue ASN expr {Assign (Vari $1,$3)}
| TYPE VARIABLE ASN typ_list {Custom_types($2,$4)}
| typ VARIABLE LBRACK VARIABLE RBRACK ASN expr {Array_assign($1,$2,$4,$7)}

| RETAIN expr {Memory_manage (Retain, Expr' $2)}
| Float_Lit {Float_literal ($1)}
| LBRACK array_element RBRACK { Array($2) } 
| BLIT {Blit $1} 
| Literal {Literal($1)} 
| String_Lit  { Stirng_literal ($1)} 




all_simple_assignment:
| expr EQ expr { Binop($1, Eq, $3) }
| expr NEQ expr { Binop($1, Neq, $3) }
| expr LT expr{ Binop($1,Lt, $3) }
| expr GT expr { Binop($1, Gt, $3) }
| expr LEQ expr { Binop($1,Lteq, $3) }
| expr GEQ expr { Binop($1,Rteq, $3) }
| expr AND expr { Binop($1, And, $3) }
| expr OR expr { Binop($1, Or, $3) }
| expr PLUS expr { Binop($1, Plus, $3) }
| expr MINUS expr { Binop($1, Minus, $3) }
| expr TIMES expr { Binop($1, Times, $3) }
| expr DIVIDE expr { Binop($1, Divde, $3) }
| expr EXP expr { Binop($1, Exp, $3) }
| expr MODULUS expr  { Binop($1, Mod, $3) }


args_opt:
{[]}
| args { $1 }

args:
expr  { [$1] }
  | expr COMMA args { $1::$3 }
  

