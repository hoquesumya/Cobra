%{
    open Ast
%}
%token EOL TAB Colon IF ELSE ELIF NONELSE NOT AND OR  PLUS  MINUS DIVIDE TIMES
%token EQ MODULUS NEQ LT RT LTEQ RTEQ  EXP PLUSEQ MINUSEQ TIMESEQ
%token DIVIDEEQ LBRACE RBRACE LBRACK RBRACK LPAREN RPAREN
%token ASSIGN COMMA COMMA BREAK CONTINUE CLASS PUBLIC PRIVATE STATIC
%token INT BOOL STRING FLOAT REF TYPE FOR WHILE DEF RETURN  NULL Nan IMPORT
%token NEW DELETE FREE TRY CATCH RVAL EXCEPT VIRTUAL IN RANGE DOT DEREF
%token <string> String_Lit 
%token <string> Variable
%token <int> Literal
%token <float> Float_Lit
%token <bool> BLIT
%token INDENT DEDENT (*to keep track of the indentation for block of statement*)
%token EOF TUPLE LIST VARTUAL

%start tokenize
%type <token list> tokenize 


%start program_rule
%type <Ast.program>program_rule

%nonassoc NOELSE /* handles shift-reduce error for else and noelse clauses */
%nonassoc ELIF
%nonassoc ELSE 


%right ASSIGN PLUSEQ MINUSEQ TIMESEQ DIVIDEEQ
%left DOT
%left OR
%left AND
%left EQ NEQ 
%left LT GT LTEQ RTEQ 
%left PLUS  MINUS
%left TIMES DIVIDE
%left EXP (*higher precendence*)
%right DEREF
%left EOL

%nonassoc LPAREN LBRACK LBRACE
%nonassoc RPAREN RBRACK RBRACE
%%

tokenize:
  | seq EOL { $1 @ [EOL] }
  | EOL { NOP :: [EOL] }

/* seq: an auxillary target used to handle shift reduce errors in tokenize */

seq:
  | token { [$1] }
  | token seq { $1 :: $2 }
token:

  | Colon { Colon }
  | TAB { TAB }
  | RVAL{ RVAL }
  | RETURN { RETURN }
  | NOT { NOT }
  | IF { IF }
  | ELSE { ELSE }
  | FOR { FOR }
  | WHILE { WHILE }
  | DEF { DEF }
  | NEQ { NEQ }
  | LT { LT }
  | GT { GT }
  | LTEQ { LTEQ }
  | RTEQ { RTEQ }
  | AND { AND }
  | CONTINUE { CONTINUE }
  | BREAK { BREAK }
  | OR { OR }
  | IN { IN }
  | PLUS { PLUS }
  | MINUS { MINUS }
  | TIMES { TIMES }
  | DIVIDE { DIVIDE }
  | EXP { EXP }
  | PLUSEQ { PLUSEQ }
  | MINUSEQ { MINUSEQ }
  | TIMESEQ { TIMESEQ }
  | DIVIDEEQ { DIVIDEEQ }
  | LPAREN { LPAREN }
  | RPAREN { RPAREN }
  | LBRACK { LBRACK }
  | RBRACK { RBRACK }
  | LBRACE { LBRACE }
  | RBRACE { RBRACE }
  | EQ { EQ }
  | ASSIGN { ASSIGN }
  | BOOL { BOOL }
  | INT { INT }
  | FLOAT { FLOAT }
  | STRING { STRING }
  | INDENT { INDENT }
  | DEDENT { DEDENT }
  | Variable { Variable($1) }
  | Float_Lit { Float_Lit($1) }
  | Literal { Literal($1) }
  | BLIT { BLIT($1) }
  |  String_Lit  {  String_Lit ($1) }
  | EOF { EOF }
  | CLASS { CLASS }
  | DOT { DOT }
  | RANGE { RANGE }


program_rule:
 |stmt_rule_list EOF {{body=$1}}

(*now define non-termianl stmt_rule_list*)
stmt_rule_list:
 (*nothing no statement*)  {[]}
 |stmt_rule stmt_rule_list {$1 :: $2} (*head of the list followed by tail*)
(*
define stmt consists of termainals and nonterminals
*)
typ:
INT {Int}
| BOOL {Bool}
| STRING {String}
| FLOAT { Float}
| TUPLE {Tuple}
| LIST {List}

stmt_rule:
 expr_rule EOL {Expr ($1)}
 |stmt_rule EOL {$1}
 | RETURN expr_rule EOL {$2}
 | CLASS Variable LPAREN list_parameter_list RPAREN Colon EOL statement_block {Class ($2,$4,$8)}
 | VIRTUAL CLASS Variable Colon statement_block {Virtual_Class($3,$5)}
 | FOR bind_var IN expr_rule Colon EOL statement_block {For($2,$4,$7)}
 (* FOR bind_var IN RANGE LPAREN expr_rule RPAREN Colon EOL INDENT stmt_rule_list DEDENT {Range ($2, $6, $11)}
* shift and reduce conflict*)
 | WHILE expr_rule Colon EOL statement_block { While($2, $5) }
 | IF expr_rule Colon EOL statement_block %prec NONELSE {if ($2,$5,$Block([])])}
 | IF expr_rule Colon EOL statement_block elif_block_list ELSE Colon EOL statement_block {ifElif($2,$5,Elif($6),$10)}
 | BREAK EOL {Break}
 | CONTINUE EOL {Continue}

 elif_block_list:
 | (*nothing*) {[]}
 | elif_block elif_block_list {$1::$2}

 elif_block:
 | ELIF expr_rule Colon EOL statement_block {elif($2,$5)}

statement_block:
INDENT stmt_rule_list {Block ($2)}
list_parameter_list:
(*no argument*) {[]}
    |list_arg list_parameter_list {$1::$2}
list_arg:
   bind_var {[$1]}
   | bind_var COMMA list_arg {$1 :: $3}
bind_var:
   (*dynamic typing*)
    Variable {Bind($1,Dynamic)}
    |Variable Colon typ {Bind($1,$3)}
(*will be a list*)


list_argument:
|(*nothing*) {[]}
| expr_rule {[$1]}
| expr_rule COMMA list_argument {$1 :: $3}
(*encountering shift/reduce conflict*)
all_val:
  bind_var {Variable ($1)}
  | list_access { $1 }
  | LBRACK list_argument RBRACK  {$2}
(*occurs shift/reduce conflicts*)
list_access:
  | expr_rule LBRACK expr_rule RBRACK { ListAccess($1, $3) }


expr_rule:
    Literal {Literal($1)} 
    | list_access {$1}(*terminal*)
    | String_Lit  { Stirng_literal ($1)} (*terminal*)
    | Float_Lit {Float_literal ($1)} (*terminal*)
    | BLIT {Bool $1}
    | Variable {Variable($1,Dynamic)} (*terminal*)
    | expr_rule LPAREN list_argument RPAREN {Func_call($1,$3)}(*function call example  x(4,5)*)
    | expr_rule DOT Variable LPAREN list_argument RPAREN {Class_Method ($1, $3, $5)}
    | LBRACK list_argument RBRACK   {List($2)}   (*list []*)
    | LPAREN list_argument RPAREN {List($2)}  (*tuple()*)
    | LPAREN expr_rule RPAREN {$2}
    | DEF VARTUAL Variable LPAREN list_parameter_list RPAREN {Virtual_fun(Bind($3,Dynamic),$5)}
    | all_val ASSIGN expr_rule {Assign ($1, $3)}
    | expr_rule EQ expr_rule {Binop ($1,Eq,$3)}
    | expr_rule NEQ expr_rule { Binop ($1, NEq, $3)}
    | expr_rule LT expr_rule { Binop ($1, Lt, $3)}
    | expr_rule GT expr_rule { Binop ($1, Gt, $3)}
    | expr_rule PLUS expr_rule { Binop ($1, Plus, $3)}
    | expr_rule MINUS expr_rule { Binop ($1, Minus, $3)}
    | expr_rule TIMES expr_rule { Binop ($1, Times, $3)}
    | expr_rule DIVIDE expr_rule { Binop ($1, Divde, $3)}
    | expr_rule EXP expr_rule { Binop ($1, Exp, $3)}
    | expr_rule LTEQ expr_rule { Binop ($1, Lteq, $3)}
    | expr_rule RTEQ expr_rule { Binop ($1, Rteq, $3)}
    | expr_rule OR expr_rule   {Binop ($1, Or, $3)}
    | expr_rule AND expr_rule   {Binop ($1, And, $3)}
    | NEW expr_rule {Memory_manage (New, $2)}
    | DEREF expr_rule {Memory_manage (Deref, $2)} 
    | expr_rule LPAREN list_argument RPAREN {Func_call($1,$3)}





/*
    the shift/reduce conflict
    1. expr: 
    | 
    
     ASSIGN expr_rule {Assign ($1, $3)}
    | expr_rule binop expr_rule {Binop ($1,$2,$3)}
    | NEW expr_rule {Memory_manage (New, $2)}
    |  expr_rule LPAREN list_argument RPAREN {Func_call($1,$3)}(*function call example  x(4,5)*)
    | expr_rule DOT Variable LPAREN list_argument RPAREN {Class_Method ($1, $3, $5)}
   2. stmt: FOR bind_var IN RANGE LPAREN expr_rule RPAREN Colon EOL INDENT stmt_rule_list DEDENT {Range ($2, $6, $11)}
   3. doubt on this one: stmt:  | IF expr_rule Colon EOL statement_block elif_block_list ELSE Colon EOL statement_block {ifElif($2,$5,Elif($6),$10)}
   to do : addressof expr, mouse2 = retain DellMouse()
      makeManual mouse
      release mouse2 

  */

%%
   









