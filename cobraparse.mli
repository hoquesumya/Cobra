type token =
  | LITERAL of (
# 5 "cobraparse.mly"
        int
# 6 "cobraparse.mli"
)
  | BLIT of (
# 6 "cobraparse.mly"
        bool
# 11 "cobraparse.mli"
)
  | ID of (
# 7 "cobraparse.mly"
        string
# 16 "cobraparse.mli"
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
  | CLASS
  | ENDCLS

val program_rule :
  (Lexing.lexbuf  -> token) -> Lexing.lexbuf -> Ast.program
