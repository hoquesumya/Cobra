type token =
  | SEMI
  | LPAREN
  | RPAREN
  | LBRACE
  | RBRACE
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
# 26 "cobraparse.mli"
)
  | BLIT of (
# 13 "cobraparse.mly"
        bool
# 31 "cobraparse.mli"
)
  | ID of (
# 14 "cobraparse.mly"
        string
# 36 "cobraparse.mli"
)
  | EOF

val program :
  (Lexing.lexbuf  -> token) -> Lexing.lexbuf -> Ast.program
