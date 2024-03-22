type token =
  | EOL
  | TAB
  | Colon
  | IF
  | ELSE
  | ELIF
  | NOELSE
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
# 11 "sample.mly"
        string
# 71 "sample.mli"
)
  | Variable of (
# 12 "sample.mly"
        string
# 76 "sample.mli"
)
  | Literal of (
# 13 "sample.mly"
        int
# 81 "sample.mli"
)
  | Float_Lit of (
# 14 "sample.mly"
        float
# 86 "sample.mli"
)
  | BLIT of (
# 15 "sample.mly"
        bool
# 91 "sample.mli"
)
  | INDENT
  | DEDENT
  | EOF
  | TUPLE
  | LIST
  | VARTUAL

val program_rule :
  (Lexing.lexbuf  -> token) -> Lexing.lexbuf -> Ast.program
