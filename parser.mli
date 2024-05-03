type token =
  | LITERAL of (
# 5 "parser.mly"
        int
# 6 "parser.mli"
)
  | BLIT of (
# 6 "parser.mly"
        bool
# 11 "parser.mli"
)
  | ID of (
# 7 "parser.mly"
        string
# 16 "parser.mli"
)
  | LPAREN
  | RPAREN
  | COLON
  | COMMA
  | DEF
  | ENDEF
  | ELSE
  | IF
  | ENDIF
  | WHILE
  | NEXT
  | RETURN
  | INT
  | BOOL
  | PLUS
  | MINUS
  | ASSIGN
  | EQ
  | NEQ
  | LT
  | GT
  | LTE
  | GTE
  | EOF
  | BREAK
  | CONTINUE
  | DEREF
  | POINTER
  | MUL
  | ADDRESS_OF
  | RETAIN

val program_rule :
  (Lexing.lexbuf  -> token) -> Lexing.lexbuf -> Ast.program
