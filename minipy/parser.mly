%{ 
	open Ast
%}


%token NOELSE ASN EQ NEQ LT GT LEQ GEQ PLUS MINUS TIMES DIVIDE PLUSEQ MINUSEQ TIMESEQ DIVIDEEQ EXPEQ
%token EXP AND OR ARROW CONTINUE BREAK
%token TAB SPACE COLON  IF ELSE ELIF FOR WHILE COMMA DEF IN  RETURN NONE DOT UNION
%token BOOL INT FLOAT STRING TUPLE LIST MODULUS  SEP
%token CLASS IMPORT RANGE DELETE TYPE
%token INDENT DEDENT NEW DREF PUBLIC PRIVATE ADDRESS_OF
%token LPAREN RPAREN SAME_INDENT 
%token LBRACK RBRACK VIRTUAL NULL MAKEMANUAL RELEASE
%token LBRACE RBRACE RETAIN NOT
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
|stmt_list EOF { $1 }

stmt_list:
| {[]}
| stmt stmt_list {$1::$2}

stmt:
| expr EOL { Expr $1 }
|  IF expr COLON EOL stmt_block_list %prec NOELSE {If ($2,$5,Block([]))} 
| IF expr COLON EOL stmt_block_list ELSE COLON EOL stmt_block_list { If($2, $5, $9) } 
|  WHILE expr COLON EOL stmt_block_list {While ($2, $5)}

stmt_block_list:
	INDENT stmt_list DEDENT {Block $2}


expr:
| VARIABLE {Variable $1}
| Literal {Literal $1}
| Float_Lit {Float_literal ($1)}
| BLIT {Blit $1} 
| String_Lit  { Stirng_literal ($1)} 
| VARIABLE ASN expr {Assign ($1,$3)}
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
| expr DIVIDE expr { Binop($1, Divide, $3) }
| expr EXP expr { Binop($1, Exp, $3) }
| expr MODULUS expr  { Binop($1, Mod, $3) }
