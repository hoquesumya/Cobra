type token =
  | SEMI
  | LPAREN
  | RPAREN
  | LBRACE
  | RBRACE
  | DEF
  | ENDEF
  | ARROW
  | COLON
  | PLUS
  | MINUS
  | ASSIGN
  | EQ
  | NEQ
  | LT
  | AND
  | OR
  | IF
  | ELSE
  | WHILE
  | INT
  | BOOL
  | RETURN
  | COMMA
  | LITERAL of (
# 12 "cobraparse.mly"
        int
# 30 "cobraparse.mli"
)
  | BLIT of (
# 13 "cobraparse.mly"
        bool
# 35 "cobraparse.mli"
)
  | ID of (
# 14 "cobraparse.mly"
        string
# 40 "cobraparse.mli"
)
  | EOF

val program :
  (Lexing.lexbuf  -> token) -> Lexing.lexbuf -> Ast.program
