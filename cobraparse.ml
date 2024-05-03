type token =
  | LITERAL of (
# 5 "cobraparse.mly"
        int
# 6 "cobraparse.ml"
)
  | BLIT of (
# 6 "cobraparse.mly"
        bool
# 11 "cobraparse.ml"
)
  | ID of (
# 7 "cobraparse.mly"
        string
# 16 "cobraparse.ml"
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

open Parsing
let _ = parse_error;;
# 2 "cobraparse.mly"
open Ast
# 56 "cobraparse.ml"
let yytransl_const = [|
  260 (* LPAREN *);
  261 (* RPAREN *);
  262 (* COLON *);
  263 (* COMMA *);
  264 (* DEF *);
  265 (* ENDEF *);
  266 (* ELSE *);
  267 (* IF *);
  268 (* ENDIF *);
  269 (* WHILE *);
  270 (* NEXT *);
  271 (* RETURN *);
  272 (* INT *);
  273 (* BOOL *);
  274 (* PLUS *);
  275 (* MINUS *);
  276 (* ASSIGN *);
  277 (* EQ *);
  278 (* NEQ *);
  279 (* LT *);
  280 (* GT *);
  281 (* LTE *);
  282 (* GTE *);
    0 (* EOF *);
  283 (* BREAK *);
  284 (* CONTINUE *);
  285 (* DEREF *);
  286 (* POINTER *);
  287 (* MUL *);
  288 (* ADDRESS_OF *);
  289 (* RETAIN *);
  290 (* CLASS *);
  291 (* ENDCLS *);
    0|]

let yytransl_block = [|
  257 (* LITERAL *);
  258 (* BLIT *);
  259 (* ID *);
    0|]

let yylhs = "\255\255\
\001\000\002\000\002\000\003\000\005\000\005\000\004\000\004\000\
\004\000\004\000\004\000\004\000\004\000\004\000\006\000\006\000\
\007\000\007\000\008\000\008\000\009\000\009\000\000\000"

let yylen = "\002\000\
\002\000\001\000\002\000\001\000\001\000\002\000\001\000\001\000\
\001\000\004\000\003\000\003\000\003\000\003\000\000\000\001\000\
\001\000\003\000\000\000\001\000\001\000\003\000\002\000"

let yydefred = "\000\000\
\000\000\000\000\007\000\008\000\000\000\000\000\023\000\000\000\
\000\000\000\000\000\000\000\000\000\000\001\000\003\000\000\000\
\000\000\000\000\000\000\016\000\000\000\014\000\011\000\012\000\
\000\000\010\000\018\000"

let yydgoto = "\002\000\
\007\000\008\000\009\000\010\000\000\000\019\000\020\000\000\000\
\000\000"

let yysindex = "\003\000\
\023\255\000\000\000\000\000\000\254\254\023\255\000\000\007\000\
\023\255\250\254\023\255\023\255\004\255\000\000\000\000\023\255\
\023\255\252\254\011\255\000\000\250\254\000\000\000\000\000\000\
\023\255\000\000\000\000"

let yyrindex = "\000\000\
\000\000\000\000\000\000\000\000\001\000\000\000\000\000\000\000\
\017\000\020\000\016\255\000\000\000\000\000\000\000\000\000\000\
\000\000\024\255\000\000\000\000\008\000\000\000\000\000\000\000\
\000\000\000\000\000\000"

let yygindex = "\000\000\
\000\000\019\000\000\000\250\255\000\000\000\000\005\000\000\000\
\000\000"

let yytablesize = 280
let yytable = "\013\000\
\009\000\011\000\025\000\001\000\018\000\021\000\014\000\013\000\
\022\000\023\000\024\000\016\000\017\000\016\000\017\000\026\000\
\002\000\012\000\018\000\004\000\015\000\016\000\017\000\003\000\
\004\000\005\000\006\000\015\000\017\000\027\000\000\000\000\000\
\000\000\000\000\000\000\000\000\000\000\000\000\000\000\000\000\
\000\000\000\000\000\000\000\000\000\000\000\000\000\000\000\000\
\000\000\000\000\000\000\000\000\000\000\000\000\000\000\000\000\
\000\000\000\000\000\000\000\000\000\000\000\000\000\000\000\000\
\000\000\000\000\000\000\000\000\000\000\000\000\000\000\000\000\
\000\000\000\000\000\000\000\000\000\000\000\000\000\000\000\000\
\000\000\000\000\000\000\000\000\000\000\000\000\000\000\000\000\
\000\000\000\000\000\000\000\000\000\000\000\000\000\000\000\000\
\000\000\000\000\000\000\000\000\000\000\000\000\000\000\000\000\
\000\000\000\000\000\000\000\000\000\000\000\000\000\000\000\000\
\000\000\000\000\000\000\000\000\000\000\000\000\000\000\000\000\
\000\000\000\000\000\000\000\000\000\000\000\000\000\000\000\000\
\000\000\000\000\000\000\000\000\000\000\000\000\000\000\000\000\
\000\000\000\000\000\000\000\000\000\000\000\000\000\000\000\000\
\000\000\000\000\000\000\000\000\000\000\000\000\000\000\000\000\
\000\000\000\000\000\000\000\000\000\000\000\000\000\000\000\000\
\000\000\000\000\000\000\000\000\000\000\000\000\000\000\000\000\
\000\000\000\000\000\000\000\000\000\000\000\000\000\000\000\000\
\000\000\000\000\000\000\000\000\000\000\000\000\000\000\000\000\
\000\000\000\000\000\000\000\000\000\000\000\000\000\000\000\000\
\000\000\000\000\000\000\000\000\000\000\000\000\000\000\000\000\
\000\000\000\000\000\000\000\000\000\000\000\000\000\000\000\000\
\000\000\000\000\000\000\000\000\000\000\000\000\000\000\000\000\
\000\000\000\000\000\000\000\000\000\000\000\000\000\000\000\000\
\000\000\000\000\000\000\000\000\000\000\000\000\000\000\000\000\
\000\000\000\000\000\000\000\000\000\000\000\000\000\000\000\000\
\000\000\000\000\000\000\000\000\000\000\000\000\000\000\000\000\
\000\000\000\000\000\000\000\000\000\000\000\000\000\000\000\000\
\000\000\009\000\009\000\009\000\000\000\009\000\000\000\009\000\
\013\000\013\000\013\000\013\000\013\000\000\000\013\000\000\000\
\000\000\000\000\009\000\009\000\004\000\004\000\004\000\004\000"

let yycheck = "\006\000\
\000\000\004\001\007\001\001\000\011\000\012\000\000\000\000\000\
\005\001\016\000\017\000\018\001\019\001\018\001\019\001\005\001\
\000\000\020\001\025\000\000\000\005\001\018\001\019\001\001\001\
\002\001\003\001\004\001\009\000\005\001\025\000\255\255\255\255\
\255\255\255\255\255\255\255\255\255\255\255\255\255\255\255\255\
\255\255\255\255\255\255\255\255\255\255\255\255\255\255\255\255\
\255\255\255\255\255\255\255\255\255\255\255\255\255\255\255\255\
\255\255\255\255\255\255\255\255\255\255\255\255\255\255\255\255\
\255\255\255\255\255\255\255\255\255\255\255\255\255\255\255\255\
\255\255\255\255\255\255\255\255\255\255\255\255\255\255\255\255\
\255\255\255\255\255\255\255\255\255\255\255\255\255\255\255\255\
\255\255\255\255\255\255\255\255\255\255\255\255\255\255\255\255\
\255\255\255\255\255\255\255\255\255\255\255\255\255\255\255\255\
\255\255\255\255\255\255\255\255\255\255\255\255\255\255\255\255\
\255\255\255\255\255\255\255\255\255\255\255\255\255\255\255\255\
\255\255\255\255\255\255\255\255\255\255\255\255\255\255\255\255\
\255\255\255\255\255\255\255\255\255\255\255\255\255\255\255\255\
\255\255\255\255\255\255\255\255\255\255\255\255\255\255\255\255\
\255\255\255\255\255\255\255\255\255\255\255\255\255\255\255\255\
\255\255\255\255\255\255\255\255\255\255\255\255\255\255\255\255\
\255\255\255\255\255\255\255\255\255\255\255\255\255\255\255\255\
\255\255\255\255\255\255\255\255\255\255\255\255\255\255\255\255\
\255\255\255\255\255\255\255\255\255\255\255\255\255\255\255\255\
\255\255\255\255\255\255\255\255\255\255\255\255\255\255\255\255\
\255\255\255\255\255\255\255\255\255\255\255\255\255\255\255\255\
\255\255\255\255\255\255\255\255\255\255\255\255\255\255\255\255\
\255\255\255\255\255\255\255\255\255\255\255\255\255\255\255\255\
\255\255\255\255\255\255\255\255\255\255\255\255\255\255\255\255\
\255\255\255\255\255\255\255\255\255\255\255\255\255\255\255\255\
\255\255\255\255\255\255\255\255\255\255\255\255\255\255\255\255\
\255\255\255\255\255\255\255\255\255\255\255\255\255\255\255\255\
\255\255\255\255\255\255\255\255\255\255\255\255\255\255\255\255\
\255\255\001\001\002\001\003\001\255\255\005\001\255\255\007\001\
\001\001\002\001\003\001\004\001\005\001\255\255\007\001\255\255\
\255\255\255\255\018\001\019\001\001\001\002\001\003\001\004\001"

let yynames_const = "\
  LPAREN\000\
  RPAREN\000\
  COLON\000\
  COMMA\000\
  DEF\000\
  ENDEF\000\
  ELSE\000\
  IF\000\
  ENDIF\000\
  WHILE\000\
  NEXT\000\
  RETURN\000\
  INT\000\
  BOOL\000\
  PLUS\000\
  MINUS\000\
  ASSIGN\000\
  EQ\000\
  NEQ\000\
  LT\000\
  GT\000\
  LTE\000\
  GTE\000\
  EOF\000\
  BREAK\000\
  CONTINUE\000\
  DEREF\000\
  POINTER\000\
  MUL\000\
  ADDRESS_OF\000\
  RETAIN\000\
  CLASS\000\
  ENDCLS\000\
  "

let yynames_block = "\
  LITERAL\000\
  BLIT\000\
  ID\000\
  "

let yyact = [|
  (fun _ -> failwith "parser")
; (fun __caml_parser_env ->
    let _1 = (Parsing.peek_val __caml_parser_env 1 : 'statements) in
    Obj.repr(
# 29 "cobraparse.mly"
                   ( { locals = []; body = _1 } )
# 259 "cobraparse.ml"
               : Ast.program))
; (fun __caml_parser_env ->
    let _1 = (Parsing.peek_val __caml_parser_env 0 : 'statement) in
    Obj.repr(
# 32 "cobraparse.mly"
              ( [_1] )
# 266 "cobraparse.ml"
               : 'statements))
; (fun __caml_parser_env ->
    let _1 = (Parsing.peek_val __caml_parser_env 1 : 'statement) in
    let _2 = (Parsing.peek_val __caml_parser_env 0 : 'statements) in
    Obj.repr(
# 33 "cobraparse.mly"
                         ( _1 :: _2 )
# 274 "cobraparse.ml"
               : 'statements))
; (fun __caml_parser_env ->
    let _1 = (Parsing.peek_val __caml_parser_env 0 : 'expr) in
    Obj.repr(
# 36 "cobraparse.mly"
         (_1)
# 281 "cobraparse.ml"
               : 'statement))
; (fun __caml_parser_env ->
    let _1 = (Parsing.peek_val __caml_parser_env 0 : 'statement) in
    Obj.repr(
# 41 "cobraparse.mly"
              ( [_1] )
# 288 "cobraparse.ml"
               : 'statement_list))
; (fun __caml_parser_env ->
    let _1 = (Parsing.peek_val __caml_parser_env 1 : 'statement) in
    let _2 = (Parsing.peek_val __caml_parser_env 0 : 'statement_list) in
    Obj.repr(
# 42 "cobraparse.mly"
                             ( _1 :: _2 )
# 296 "cobraparse.ml"
               : 'statement_list))
; (fun __caml_parser_env ->
    let _1 = (Parsing.peek_val __caml_parser_env 0 : int) in
    Obj.repr(
# 45 "cobraparse.mly"
            ( Literal _1 )
# 303 "cobraparse.ml"
               : 'expr))
; (fun __caml_parser_env ->
    let _1 = (Parsing.peek_val __caml_parser_env 0 : bool) in
    Obj.repr(
# 46 "cobraparse.mly"
         ( BoolLit _1 )
# 310 "cobraparse.ml"
               : 'expr))
; (fun __caml_parser_env ->
    let _1 = (Parsing.peek_val __caml_parser_env 0 : string) in
    Obj.repr(
# 47 "cobraparse.mly"
       (Var _1)
# 317 "cobraparse.ml"
               : 'expr))
; (fun __caml_parser_env ->
    let _1 = (Parsing.peek_val __caml_parser_env 3 : string) in
    let _3 = (Parsing.peek_val __caml_parser_env 1 : 'args_opt) in
    Obj.repr(
# 48 "cobraparse.mly"
                              (Call(_1, _3))
# 325 "cobraparse.ml"
               : 'expr))
; (fun __caml_parser_env ->
    let _1 = (Parsing.peek_val __caml_parser_env 2 : 'expr) in
    let _3 = (Parsing.peek_val __caml_parser_env 0 : 'expr) in
    Obj.repr(
# 49 "cobraparse.mly"
                   ( Binop (_1, Add, _3) )
# 333 "cobraparse.ml"
               : 'expr))
; (fun __caml_parser_env ->
    let _1 = (Parsing.peek_val __caml_parser_env 2 : 'expr) in
    let _3 = (Parsing.peek_val __caml_parser_env 0 : 'expr) in
    Obj.repr(
# 50 "cobraparse.mly"
                    ( Binop (_1, Sub, _3) )
# 341 "cobraparse.ml"
               : 'expr))
; (fun __caml_parser_env ->
    let _1 = (Parsing.peek_val __caml_parser_env 2 : string) in
    let _3 = (Parsing.peek_val __caml_parser_env 0 : 'expr) in
    Obj.repr(
# 51 "cobraparse.mly"
                   ( Assign (_1, _3) )
# 349 "cobraparse.ml"
               : 'expr))
; (fun __caml_parser_env ->
    let _2 = (Parsing.peek_val __caml_parser_env 1 : 'expr) in
    Obj.repr(
# 52 "cobraparse.mly"
                       (_2)
# 356 "cobraparse.ml"
               : 'expr))
; (fun __caml_parser_env ->
    Obj.repr(
# 57 "cobraparse.mly"
    ( [] )
# 362 "cobraparse.ml"
               : 'args_opt))
; (fun __caml_parser_env ->
    let _1 = (Parsing.peek_val __caml_parser_env 0 : 'args) in
    Obj.repr(
# 58 "cobraparse.mly"
         ( _1 )
# 369 "cobraparse.ml"
               : 'args_opt))
; (fun __caml_parser_env ->
    let _1 = (Parsing.peek_val __caml_parser_env 0 : 'expr) in
    Obj.repr(
# 61 "cobraparse.mly"
         ( [_1] )
# 376 "cobraparse.ml"
               : 'args))
; (fun __caml_parser_env ->
    let _1 = (Parsing.peek_val __caml_parser_env 2 : 'expr) in
    let _3 = (Parsing.peek_val __caml_parser_env 0 : 'args) in
    Obj.repr(
# 62 "cobraparse.mly"
                   ( _1 :: _3 )
# 384 "cobraparse.ml"
               : 'args))
; (fun __caml_parser_env ->
    Obj.repr(
# 65 "cobraparse.mly"
     ( [] )
# 390 "cobraparse.ml"
               : 'parameters))
; (fun __caml_parser_env ->
    let _1 = (Parsing.peek_val __caml_parser_env 0 : 'parameter_list) in
    Obj.repr(
# 66 "cobraparse.mly"
                   ( _1 )
# 397 "cobraparse.ml"
               : 'parameters))
; (fun __caml_parser_env ->
    let _1 = (Parsing.peek_val __caml_parser_env 0 : string) in
    Obj.repr(
# 69 "cobraparse.mly"
       ( [_1] )
# 404 "cobraparse.ml"
               : 'parameter_list))
; (fun __caml_parser_env ->
    let _1 = (Parsing.peek_val __caml_parser_env 2 : string) in
    let _3 = (Parsing.peek_val __caml_parser_env 0 : 'parameter_list) in
    Obj.repr(
# 70 "cobraparse.mly"
                            ( _1 :: _3 )
# 412 "cobraparse.ml"
               : 'parameter_list))
(* Entry program_rule *)
; (fun __caml_parser_env -> raise (Parsing.YYexit (Parsing.peek_val __caml_parser_env 0)))
|]
let yytables =
  { Parsing.actions=yyact;
    Parsing.transl_const=yytransl_const;
    Parsing.transl_block=yytransl_block;
    Parsing.lhs=yylhs;
    Parsing.len=yylen;
    Parsing.defred=yydefred;
    Parsing.dgoto=yydgoto;
    Parsing.sindex=yysindex;
    Parsing.rindex=yyrindex;
    Parsing.gindex=yygindex;
    Parsing.tablesize=yytablesize;
    Parsing.table=yytable;
    Parsing.check=yycheck;
    Parsing.error_function=parse_error;
    Parsing.names_const=yynames_const;
    Parsing.names_block=yynames_block }
let program_rule (lexfun : Lexing.lexbuf -> token) (lexbuf : Lexing.lexbuf) =
   (Parsing.yyparse yytables 1 lexfun lexbuf : Ast.program)
