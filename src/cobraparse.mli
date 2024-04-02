type token =
  | NOELSE
  | ASN
  | EQ
  | NEQ
  | LT
  | GT
  | LEQ
  | GEQ
  | PLUS
  | MINUS
  | TIMES
  | DIVIDE
  | PLUSEQ
  | MINUSEQ
  | TIMESEQ
  | DIVIDEEQ
  | EXPEQ
  | EXP
  | AND
  | OR
  | ARROW
  | CONTINUE
  | BREAK
  | TAB
  | SPACE
  | COLON
  | EOF
  | EOL
  | IF
  | ELSE
  | ELIF
  | FOR
  | WHILE
  | COMMA
  | DEF
  | IN
  | RETURN
  | NONE
  | DOT
  | UNION
  | BOOL
  | INT
  | FLOAT
  | STRING
  | TUPLE
  | LIST
  | MODULUS
  | SEP
  | CLASS
  | IMPORT
  | RANGE
  | DELETE
  | TYPE
  | INDENT
  | DEDENT
  | NEW
  | DREF
  | PUBLIC
  | PRIVATE
  | ADDRESS_OF
  | LPAREN
  | RPAREN
  | LBRACK
  | RBRACK
  | VIRTUAL
  | NULL
  | MAKEMANUAL
  | RELEASE
  | LBRACE
  | RBRACE
  | RETAIN
  | VARIABLE of (
# 15 "src/cobraparse.mly"
        string
# 77 "src/cobraparse.mli"
)
  | ID of (
# 16 "src/cobraparse.mly"
        string
# 82 "src/cobraparse.mli"
)
  | Float_Lit of (
# 18 "src/cobraparse.mly"
        float
# 87 "src/cobraparse.mli"
)
  | String_Lit of (
# 19 "src/cobraparse.mly"
        string
# 92 "src/cobraparse.mli"
)
  | Literal of (
# 20 "src/cobraparse.mly"
        int
# 97 "src/cobraparse.mli"
)
  | BLIT of (
# 21 "src/cobraparse.mly"
        bool
# 102 "src/cobraparse.mli"
)

val program :
  (Lexing.lexbuf  -> token) -> Lexing.lexbuf -> Ast.stmt
