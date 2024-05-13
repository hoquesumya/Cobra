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
  | NEWLINE
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
# 31 "cobraparse.mli"
)
  | BLIT of (
# 13 "cobraparse.mly"
        bool
# 36 "cobraparse.mli"
)
  | ID of (
# 14 "cobraparse.mly"
        string
# 41 "cobraparse.mli"
)
  | EOF

val program :
  (Lexing.lexbuf  -> token) -> Lexing.lexbuf -> Ast.program
