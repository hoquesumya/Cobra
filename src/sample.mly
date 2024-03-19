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

%start program_rule
%type <Ast.program>program_rule

%nonassoc NOELSE /* handles shift-reduce error for else and noelse clauses */
%nonassoc ELIF
%nonassoc ELSE 


%right ASSIGN PLUSEQ MINUSEQ TIMESEQ DIVIDEEQ
%left DOT NEW
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


program_rule:
 |stmt_rule_list EOF {{body=$1}}

(*now define non-termianl stmt_rule_list*)
stmt_rule_list:
 (*nothing no statement*)  {[]}
 |stmt_rule stmt_rule_list {$1 :: $2}

 stmt_rule:
 expr_rule EOL expr_rule {Expr ($1)}
 | DEF Variable LPAREN list_parameter_list RPAREN Colon EOL statement_block{Function(Bind($2,Dynamic),$4,$8)} (*conflict*)
 | DEF Variable LPAREN list_parameter_list RPAREN RVAL typ Colon EOL statement_block {Function(Bind($2,$7),$4,$10)} (*conflict*)
 | RETURN expr_rule EOL {$2}
 | CLASS Variable LPAREN list_parameter_list RPAREN Colon EOL statement_block {Class ($2,$4,$8)}
 | VIRTUAL CLASS Variable Colon statement_block {Virtual_Class($3,$5)} (*onflict*)



 statement_block:
    INDENT stmt_rule_list {Block ($2)}

(*we have mutilple types of assignment*)

typ:
INT {Int}
| BOOL {Bool}
| STRING {String}
| FLOAT { Float}
| TUPLE {Tuple}
| LIST {List}

bind_var:
   (*dynamic typing*)
    Variable {Bind($1,Dynamic)}
    |Variable Colon typ {Bind($1,$3)}

 list_argument:
|(*nothing*) {[]}
| list_of_arg {$1}
list_of_arg:
 | expr_rule {[$1]}
 | expr_rule COMMA list_of_arg{$1::$3}
 
 (*list of parameters for functions*)

 list_parameter_list:
(*no argument*) {[]}
    |list_arg list_parameter_list {$1::$2}
list_arg:
   bind_var {[$1]}
   | bind_var COMMA list_arg {$1 :: $3}
  

 expr_rule:
    Literal {Literal($1)} 
    | String_Lit  { Stirng_literal ($1)} (*terminal*)
    | Float_Lit {Float_literal ($1)} (*terminal*)
    | BLIT {Bool $1}
    | bind_var {$1} 
    (*all mathematical grammer*)
    | expr_rule EQ expr_rule {Binop ($1,Eq,$3)}
    | expr_rule NEQ expr_rule { Binop ($1, NEq, $3)}
    |  expr_rule LT expr_rule { Binop ($1, Lt, $3)}
    | expr_rule GT expr_rule { Binop ($1, Gt, $3)}
    | expr_rule PLUS expr_rule { Binop ($1, Plus, $3)}
    | expr_rule MINUS expr_rule { Binop ($1, Minus, $3)}
    | expr_rule TIMES expr_rule { Binop ($1, Times, $3)}
    | expr_rule DIVIDE expr_rule { Binop ($1, Divde, $3)}
    | expr_rule EXP expr_rule { Binop ($1, Exp, $3)}
    | expr_rule LTEQ expr_rule { Binop ($1, Lteq, $3)}
    | expr_rule RTEQ expr_rule { Binop ($1, Rteq, $3)}
    | expr_rule OR expr_rule   {Binop ($1, Or, $3)}
    | expr_rule AND expr_rule  {Binop ($1, And, $3)}
     (*memory related*)
    | DEREF expr_rule {Memory_manage (Deref, $2)} 
    | NEW expr_rule {Memory_manage (New, $2)}
    (*class and function method*)
    | expr_rule LPAREN list_argument RPAREN {Func_call($1,$3)} (*function call*)
    | expr_rule DOT Variable LPAREN list_argument RPAREN {Class_Method ($1, $3, $5)}
    | LBRACK list_argument RBRACK   {List($2)}   (*list []*)
    | LPAREN list_argument RPAREN {List($2)}  (*tuple()*)
    (*assignment multiple types of assignemnt, variable assignment,list assignment*)
    (*need a list?*)
    (*this one needs to be fixed*)
    | bind_var ASSIGN expr_rule {Assign($1,$3)}
    | expr_rule LBRACK expr_rule RBRACK  ASSIGN expr_rule{ ListAccess($1, $3) }
    | LBRACK list_argument RBRACK ASSIGN expr_rule {ListAccess($2,$5)}  (*I just want to have the variable*)
   (* | VIRTUAL DEF Variable LPAREN list_parameter_list RPAREN {Virtual_fun(Bind($3,Dynamic),$5)} *) (*conflict*)