/* Ocamlyacc parser for Cobra */

%{
open Ast
%}

%token SEMI LPAREN RPAREN LBRACE RBRACE DEF ENDEF ARROW COLON PLUS MINUS MULT DIV ASSIGN
%token EQ NEQ LT GT LTE GTE AND OR
%token IF ELSE WHILE INT BOOL
/* return, COMMA token */
%token RETURN COMMA
%token <int> LITERAL
%token <bool> BLIT
%token <string> ID
%token EOF

%start program
%type <Ast.program> program

%right ASSIGN
%left OR
%left AND
%left EQ NEQ
%left LT LTE GT GTE
%left PLUS MINUS
%left MULT DIV

%%

/* add function declarations*/
program:
  decls EOF { $1 }

decls:
   /* nothing */ { ([], [])               }
 | vdecl SEMI decls { (($1 :: fst $3), snd $3) }
 | fdecl SEMI decls { (fst $3, ($1 :: snd $3)) }

vdecl_list:
  /*nothing*/ { [] }
  | vdecl SEMI vdecl_list  { $1 :: $3 }

/* int x */
vdecl:
  typ ID { ($1, $2) }

typ:
    INT   { Int   }
  | BOOL  { Bool  }

/* fdecl */
fdecl:
  DEF ID LPAREN formals_opt RPAREN ARROW typ COLON SEMI vdecl_list stmt_list ENDEF
  {
    {
      rtyp=$7;
      fname=$2;
      formals=$4;
      locals=$10;
      body=$11
    }
  }

/* formals_opt */
formals_opt:
  /*nothing*/ { [] }
  | formals_list { $1 }

formals_list:
  vdecl { [$1] }
  | vdecl COMMA formals_list { $1::$3 }

stmt_list:
  /* nothing */ { [] }
  | stmt SEMI stmt_list  { $1::$3 }

stmt:
    expr                               { Expr $1      }
  | COLON SEMI stmt_list ENDEF                { Block $3}
  /* if (condition) { block1} else {block2} */
  /* if (condition) stmt else stmt */
  | IF LPAREN expr RPAREN stmt ELSE stmt    { If($3, $5, $7) }
  | WHILE LPAREN expr RPAREN stmt           { While ($3, $5)  }
  /* return */
  | RETURN expr                        { Return $2      }

expr:
    LITERAL          { Literal($1)            }
  | BLIT             { BoolLit($1)            }
  | ID               { Id($1)                 }
  | expr PLUS   expr { Binop($1, Add,   $3)   }
  | expr MINUS  expr { Binop($1, Sub,   $3)   }
  | expr MULT   expr { Binop($1, Mult,   $3)   }
  | expr DIV    expr { Binop($1, Divide,   $3)   }
  | expr EQ     expr { Binop($1, Equal, $3)   }
  | expr NEQ    expr { Binop($1, Neq, $3)     }
  | expr LT     expr { Binop($1, Less,  $3)   }
  | expr GT     expr { Binop($1, Greater,  $3)   }
  | expr LTE    expr { Binop($1, LessEq,  $3)   }
  | expr GTE    expr { Binop($1, GreaterEq,  $3)   }
  | expr AND    expr { Binop($1, And,   $3)   }
  | expr OR     expr { Binop($1, Or,    $3)   }
  | ID ASSIGN expr   { Assign($1, $3)         }
  | LPAREN expr RPAREN { $2                   }
  /* call */
  | ID LPAREN args_opt RPAREN { Call ($1, $3)  }

/* args_opt*/
args_opt:
  /*nothing*/ { [] }
  | args { $1 }

args:
  expr  { [$1] }
  | expr COMMA args { $1::$3 }
