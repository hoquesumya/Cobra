type token =
  | EOL
  | TAB
  | Colon
  | IF
  | ELSE
  | ELIF
  | NONELSE
  | NOT
  | AND
  | OR
  | PLUS
  | MINUS
  | DIVIDE
  | TIMES
  | EQ
  | MODULUS
  | NEQ
  | LT
  | RT
  | LTEQ
  | RTEQ
  | EXP
  | PLUSEQ
  | MINUSEQ
  | TIMESEQ
  | DIVIDEEQ
  | LBRACE
  | RBRACE
  | LBRACK
  | RBRACK
  | LPAREN
  | RPAREN
  | ASSIGN
  | COMMA
  | BREAK
  | CONTINUE
  | CLASS
  | PUBLIC
  | PRIVATE
  | STATIC
  | INT
  | BOOL
  | STRING
  | FLOAT
  | REF
  | TYPE
  | FOR
  | WHILE
  | DEF
  | RETURN
  | NULL
  | Nan
  | IMPORT
  | NEW
  | DELETE
  | FREE
  | TRY
  | CATCH
  | RVAL
  | EXCEPT
  | VIRTUAL
  | IN
  | RANGE
  | DOT
  | DEREF
  | String_Lit of (
# 10 "cobraparse.mly"
        string
# 71 "cobraparse.mli"
)
  | Variable of (
# 11 "cobraparse.mly"
        string
# 76 "cobraparse.mli"
)
  | Literal of (
# 12 "cobraparse.mly"
        int
# 81 "cobraparse.mli"
)
  | Float_Lit of (
# 13 "cobraparse.mly"
        float
# 86 "cobraparse.mli"
)
  | BLIT of (
# 14 "cobraparse.mly"
        bool
# 91 "cobraparse.mli"
)
  | INDENT
  | DEDENT
  | EOF
  | TUPLE
  | LIST
  | VARTUAL

val tokenize :
  (Lexing.lexbuf  -> token) -> Lexing.lexbuf -> token list
val program_rule :
  (Lexing.lexbuf  -> token) -> Lexing.lexbuf -> Ast.program
