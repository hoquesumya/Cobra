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
# 12 "microcparse.mly"
        int
# 26 "microcparse.mli"
)
  | BLIT of (
# 13 "microcparse.mly"
        bool
# 31 "microcparse.mli"
)
  | ID of (
# 14 "microcparse.mly"
        string
# 36 "microcparse.mli"
)
  | EOF

val program :
  (Lexing.lexbuf  -> token) -> Lexing.lexbuf -> Ast.program
