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
# 31 "cobraparse.ml"
)
  | BLIT of (
# 13 "cobraparse.mly"
        bool
# 36 "cobraparse.ml"
)
  | ID of (
# 14 "cobraparse.mly"
        string
# 41 "cobraparse.ml"
)
  | EOF

open Parsing
let _ = parse_error;;
# 4 "cobraparse.mly"
open Ast
# 49 "cobraparse.ml"
let yytransl_const = [|
  257 (* SEMI *);
  258 (* LPAREN *);
  259 (* RPAREN *);
  260 (* LBRACE *);
  261 (* RBRACE *);
  262 (* DEF *);
  263 (* ENDEF *);
  264 (* ARROW *);
  265 (* COLON *);
  266 (* NEWLINE *);
  267 (* PLUS *);
  268 (* MINUS *);
  269 (* ASSIGN *);
  270 (* EQ *);
  271 (* NEQ *);
  272 (* LT *);
  273 (* AND *);
  274 (* OR *);
  275 (* IF *);
  276 (* ELSE *);
  277 (* WHILE *);
  278 (* INT *);
  279 (* BOOL *);
  280 (* RETURN *);
  281 (* COMMA *);
    0 (* EOF *);
    0|]

let yytransl_block = [|
  282 (* LITERAL *);
  283 (* BLIT *);
  284 (* ID *);
    0|]

let yylhs = "\255\255\
\001\000\002\000\002\000\002\000\005\000\005\000\003\000\006\000\
\006\000\004\000\007\000\007\000\009\000\009\000\008\000\008\000\
\010\000\010\000\010\000\010\000\010\000\011\000\011\000\011\000\
\011\000\011\000\011\000\011\000\011\000\011\000\011\000\011\000\
\011\000\011\000\012\000\012\000\013\000\013\000\000\000"

let yylen = "\002\000\
\002\000\000\000\003\000\002\000\000\000\003\000\002\000\001\000\
\001\000\011\000\000\000\001\000\001\000\003\000\000\000\002\000\
\002\000\003\000\007\000\005\000\003\000\001\000\001\000\001\000\
\003\000\003\000\003\000\003\000\003\000\003\000\003\000\003\000\
\003\000\004\000\000\000\001\000\001\000\003\000\002\000"

let yydefred = "\000\000\
\000\000\000\000\000\000\008\000\009\000\039\000\000\000\000\000\
\000\000\000\000\000\000\001\000\000\000\004\000\007\000\000\000\
\003\000\000\000\000\000\012\000\000\000\000\000\014\000\000\000\
\000\000\000\000\000\000\000\000\000\000\000\000\000\000\000\000\
\000\000\000\000\022\000\023\000\000\000\000\000\000\000\000\000\
\006\000\000\000\000\000\000\000\000\000\000\000\000\000\000\000\
\010\000\016\000\017\000\000\000\000\000\000\000\000\000\000\000\
\000\000\000\000\033\000\018\000\000\000\000\000\021\000\000\000\
\000\000\036\000\000\000\025\000\026\000\000\000\000\000\000\000\
\000\000\000\000\000\000\000\000\000\000\034\000\000\000\020\000\
\038\000\000\000\019\000"

let yydgoto = "\002\000\
\006\000\007\000\008\000\009\000\028\000\010\000\019\000\038\000\
\020\000\039\000\040\000\065\000\066\000"

let yysindex = "\004\000\
\056\255\000\000\239\254\000\000\000\000\000\000\013\000\015\255\
\056\255\248\254\035\255\000\000\056\255\000\000\000\000\107\255\
\000\000\024\255\039\255\000\000\107\255\051\255\000\000\107\255\
\053\255\107\255\067\255\017\255\107\255\007\255\017\255\088\255\
\091\255\007\255\000\000\000\000\255\254\071\255\017\255\102\255\
\000\000\120\255\077\255\007\255\007\255\110\255\007\255\007\255\
\000\000\000\000\000\000\007\255\007\255\007\255\007\255\007\255\
\007\255\007\255\000\000\000\000\130\255\140\255\000\000\148\255\
\093\255\000\000\167\255\000\000\000\000\188\255\188\255\028\255\
\182\255\175\255\017\255\017\255\007\255\000\000\086\255\000\000\
\000\000\017\255\000\000"

let yyrindex = "\000\000\
\104\000\000\000\000\000\000\000\000\000\000\000\000\000\000\000\
\104\000\000\000\000\000\000\000\104\000\000\000\000\000\104\255\
\000\000\109\255\000\000\000\000\000\000\000\000\000\000\000\000\
\000\000\027\255\000\000\105\255\027\255\000\000\105\255\000\000\
\000\000\000\000\000\000\000\000\049\255\000\000\105\255\000\000\
\000\000\000\000\000\000\000\000\000\000\000\000\112\255\000\000\
\000\000\000\000\000\000\000\000\000\000\000\000\000\000\000\000\
\000\000\000\000\000\000\000\000\000\000\000\000\000\000\136\255\
\000\000\000\000\005\255\000\000\000\000\074\255\080\255\055\255\
\083\255\084\255\000\000\000\000\000\000\000\000\000\000\000\000\
\000\000\000\000\000\000"

let yygindex = "\000\000\
\000\000\250\255\151\000\000\000\111\000\125\000\000\000\227\255\
\129\000\093\000\226\255\000\000\076\000"

let yytablesize = 204
let yytable = "\042\000\
\047\000\043\000\014\000\046\000\001\000\032\000\017\000\032\000\
\030\000\050\000\011\000\048\000\012\000\061\000\062\000\013\000\
\064\000\067\000\030\000\015\000\031\000\068\000\069\000\070\000\
\071\000\072\000\073\000\074\000\005\000\032\000\005\000\005\000\
\035\000\036\000\037\000\032\000\016\000\033\000\052\000\053\000\
\034\000\022\000\035\000\036\000\037\000\005\000\064\000\005\000\
\021\000\024\000\005\000\024\000\005\000\005\000\005\000\029\000\
\026\000\029\000\024\000\024\000\024\000\003\000\024\000\024\000\
\024\000\024\000\024\000\029\000\029\000\029\000\029\000\029\000\
\029\000\024\000\027\000\049\000\027\000\004\000\005\000\029\000\
\028\000\060\000\028\000\030\000\031\000\030\000\031\000\027\000\
\027\000\044\000\027\000\027\000\045\000\028\000\028\000\078\000\
\028\000\028\000\027\000\030\000\030\000\031\000\051\000\002\000\
\028\000\082\000\011\000\030\000\031\000\015\000\063\000\013\000\
\052\000\053\000\035\000\054\000\055\000\056\000\057\000\058\000\
\052\000\053\000\059\000\054\000\055\000\056\000\057\000\058\000\
\004\000\005\000\052\000\053\000\075\000\054\000\055\000\056\000\
\057\000\058\000\037\000\041\000\052\000\053\000\076\000\054\000\
\055\000\056\000\057\000\058\000\025\000\023\000\052\000\053\000\
\081\000\054\000\055\000\056\000\057\000\058\000\052\000\053\000\
\000\000\054\000\055\000\056\000\057\000\058\000\018\000\079\000\
\080\000\000\000\000\000\018\000\077\000\000\000\083\000\000\000\
\027\000\052\000\053\000\027\000\054\000\055\000\056\000\057\000\
\058\000\052\000\053\000\000\000\054\000\055\000\056\000\057\000\
\052\000\053\000\000\000\054\000\055\000\056\000\052\000\053\000\
\000\000\000\000\000\000\056\000"

let yycheck = "\030\000\
\002\001\031\000\009\000\034\000\001\000\001\001\013\000\003\001\
\002\001\039\000\028\001\013\001\000\000\044\000\045\000\001\001\
\047\000\048\000\002\001\028\001\004\001\052\000\053\000\054\000\
\055\000\056\000\057\000\058\000\002\001\025\001\004\001\005\001\
\026\001\027\001\028\001\019\001\002\001\021\001\011\001\012\001\
\024\001\003\001\026\001\027\001\028\001\019\001\077\000\021\001\
\025\001\001\001\024\001\003\001\026\001\027\001\028\001\001\001\
\004\001\003\001\008\001\011\001\012\001\006\001\014\001\015\001\
\016\001\017\001\018\001\001\001\014\001\015\001\016\001\017\001\
\018\001\025\001\001\001\005\001\003\001\022\001\023\001\025\001\
\001\001\005\001\003\001\001\001\001\001\003\001\003\001\014\001\
\015\001\002\001\017\001\018\001\002\001\014\001\015\001\003\001\
\017\001\018\001\025\001\017\001\018\001\018\001\001\001\000\000\
\025\001\020\001\003\001\025\001\025\001\005\001\001\001\003\001\
\011\001\012\001\003\001\014\001\015\001\016\001\017\001\018\001\
\011\001\012\001\003\001\014\001\015\001\016\001\017\001\018\001\
\022\001\023\001\011\001\012\001\003\001\014\001\015\001\016\001\
\017\001\018\001\003\001\029\000\011\001\012\001\003\001\014\001\
\015\001\016\001\017\001\018\001\024\000\021\000\011\001\012\001\
\077\000\014\001\015\001\016\001\017\001\018\001\011\001\012\001\
\255\255\014\001\015\001\016\001\017\001\018\001\016\000\075\000\
\076\000\255\255\255\255\021\000\025\001\255\255\082\000\255\255\
\026\000\011\001\012\001\029\000\014\001\015\001\016\001\017\001\
\018\001\011\001\012\001\255\255\014\001\015\001\016\001\017\001\
\011\001\012\001\255\255\014\001\015\001\016\001\011\001\012\001\
\255\255\255\255\255\255\016\001"

let yynames_const = "\
  SEMI\000\
  LPAREN\000\
  RPAREN\000\
  LBRACE\000\
  RBRACE\000\
  DEF\000\
  ENDEF\000\
  ARROW\000\
  COLON\000\
  NEWLINE\000\
  PLUS\000\
  MINUS\000\
  ASSIGN\000\
  EQ\000\
  NEQ\000\
  LT\000\
  AND\000\
  OR\000\
  IF\000\
  ELSE\000\
  WHILE\000\
  INT\000\
  BOOL\000\
  RETURN\000\
  COMMA\000\
  EOF\000\
  "

let yynames_block = "\
  LITERAL\000\
  BLIT\000\
  ID\000\
  "

let yyact = [|
  (fun _ -> failwith "parser")
; (fun __caml_parser_env ->
    let _1 = (Parsing.peek_val __caml_parser_env 1 : 'decls) in
    Obj.repr(
# 31 "cobraparse.mly"
            ( _1)
# 245 "cobraparse.ml"
               : Ast.program))
; (fun __caml_parser_env ->
    Obj.repr(
# 34 "cobraparse.mly"
                 ( ([], [])               )
# 251 "cobraparse.ml"
               : 'decls))
; (fun __caml_parser_env ->
    let _1 = (Parsing.peek_val __caml_parser_env 2 : 'vdecl) in
    let _3 = (Parsing.peek_val __caml_parser_env 0 : 'decls) in
    Obj.repr(
# 35 "cobraparse.mly"
                    ( ((_1 :: fst _3), snd _3) )
# 259 "cobraparse.ml"
               : 'decls))
; (fun __caml_parser_env ->
    let _1 = (Parsing.peek_val __caml_parser_env 1 : 'fdecl) in
    let _2 = (Parsing.peek_val __caml_parser_env 0 : 'decls) in
    Obj.repr(
# 36 "cobraparse.mly"
               ( (fst _2, (_1 :: snd _2)) )
# 267 "cobraparse.ml"
               : 'decls))
; (fun __caml_parser_env ->
    Obj.repr(
# 39 "cobraparse.mly"
              ( [] )
# 273 "cobraparse.ml"
               : 'vdecl_list))
; (fun __caml_parser_env ->
    let _1 = (Parsing.peek_val __caml_parser_env 2 : 'vdecl) in
    let _3 = (Parsing.peek_val __caml_parser_env 0 : 'vdecl_list) in
    Obj.repr(
# 40 "cobraparse.mly"
                           (  _1 :: _3 )
# 281 "cobraparse.ml"
               : 'vdecl_list))
; (fun __caml_parser_env ->
    let _1 = (Parsing.peek_val __caml_parser_env 1 : 'typ) in
    let _2 = (Parsing.peek_val __caml_parser_env 0 : string) in
    Obj.repr(
# 44 "cobraparse.mly"
         ( (_1, _2) )
# 289 "cobraparse.ml"
               : 'vdecl))
; (fun __caml_parser_env ->
    Obj.repr(
# 47 "cobraparse.mly"
          ( Int   )
# 295 "cobraparse.ml"
               : 'typ))
; (fun __caml_parser_env ->
    Obj.repr(
# 48 "cobraparse.mly"
          ( Bool  )
# 301 "cobraparse.ml"
               : 'typ))
; (fun __caml_parser_env ->
    let _2 = (Parsing.peek_val __caml_parser_env 9 : string) in
    let _4 = (Parsing.peek_val __caml_parser_env 7 : 'formals_opt) in
    let _7 = (Parsing.peek_val __caml_parser_env 4 : 'typ) in
    let _9 = (Parsing.peek_val __caml_parser_env 2 : 'vdecl_list) in
    let _10 = (Parsing.peek_val __caml_parser_env 1 : 'stmt_list) in
    Obj.repr(
# 64 "cobraparse.mly"
  (
    {
      rtyp=_7;
      fname=_2;
      formals=_4;
      locals=_9;
      body=_10
    }
  )
# 320 "cobraparse.ml"
               : 'fdecl))
; (fun __caml_parser_env ->
    Obj.repr(
# 76 "cobraparse.mly"
              ( [] )
# 326 "cobraparse.ml"
               : 'formals_opt))
; (fun __caml_parser_env ->
    let _1 = (Parsing.peek_val __caml_parser_env 0 : 'formals_list) in
    Obj.repr(
# 77 "cobraparse.mly"
                 ( _1 )
# 333 "cobraparse.ml"
               : 'formals_opt))
; (fun __caml_parser_env ->
    let _1 = (Parsing.peek_val __caml_parser_env 0 : 'vdecl) in
    Obj.repr(
# 80 "cobraparse.mly"
        ( [_1] )
# 340 "cobraparse.ml"
               : 'formals_list))
; (fun __caml_parser_env ->
    let _1 = (Parsing.peek_val __caml_parser_env 2 : 'vdecl) in
    let _3 = (Parsing.peek_val __caml_parser_env 0 : 'formals_list) in
    Obj.repr(
# 81 "cobraparse.mly"
                             ( _1::_3 )
# 348 "cobraparse.ml"
               : 'formals_list))
; (fun __caml_parser_env ->
    Obj.repr(
# 84 "cobraparse.mly"
                ( [] )
# 354 "cobraparse.ml"
               : 'stmt_list))
; (fun __caml_parser_env ->
    let _1 = (Parsing.peek_val __caml_parser_env 1 : 'stmt) in
    let _2 = (Parsing.peek_val __caml_parser_env 0 : 'stmt_list) in
    Obj.repr(
# 85 "cobraparse.mly"
                    ( _1::_2 )
# 362 "cobraparse.ml"
               : 'stmt_list))
; (fun __caml_parser_env ->
    let _1 = (Parsing.peek_val __caml_parser_env 1 : 'expr) in
    Obj.repr(
# 88 "cobraparse.mly"
                                            ( Expr _1      )
# 369 "cobraparse.ml"
               : 'stmt))
; (fun __caml_parser_env ->
    let _2 = (Parsing.peek_val __caml_parser_env 1 : 'stmt_list) in
    Obj.repr(
# 89 "cobraparse.mly"
                                            ( Block _2 )
# 376 "cobraparse.ml"
               : 'stmt))
; (fun __caml_parser_env ->
    let _3 = (Parsing.peek_val __caml_parser_env 4 : 'expr) in
    let _5 = (Parsing.peek_val __caml_parser_env 2 : 'stmt) in
    let _7 = (Parsing.peek_val __caml_parser_env 0 : 'stmt) in
    Obj.repr(
# 92 "cobraparse.mly"
                                            ( If(_3, _5, _7) )
# 385 "cobraparse.ml"
               : 'stmt))
; (fun __caml_parser_env ->
    let _3 = (Parsing.peek_val __caml_parser_env 2 : 'expr) in
    let _5 = (Parsing.peek_val __caml_parser_env 0 : 'stmt) in
    Obj.repr(
# 93 "cobraparse.mly"
                                            ( While (_3, _5)  )
# 393 "cobraparse.ml"
               : 'stmt))
; (fun __caml_parser_env ->
    let _2 = (Parsing.peek_val __caml_parser_env 1 : 'expr) in
    Obj.repr(
# 95 "cobraparse.mly"
                                            ( Return _2      )
# 400 "cobraparse.ml"
               : 'stmt))
; (fun __caml_parser_env ->
    let _1 = (Parsing.peek_val __caml_parser_env 0 : int) in
    Obj.repr(
# 98 "cobraparse.mly"
                     ( Literal(_1)            )
# 407 "cobraparse.ml"
               : 'expr))
; (fun __caml_parser_env ->
    let _1 = (Parsing.peek_val __caml_parser_env 0 : bool) in
    Obj.repr(
# 99 "cobraparse.mly"
                     ( BoolLit(_1)            )
# 414 "cobraparse.ml"
               : 'expr))
; (fun __caml_parser_env ->
    let _1 = (Parsing.peek_val __caml_parser_env 0 : string) in
    Obj.repr(
# 100 "cobraparse.mly"
                     ( Id(_1)                 )
# 421 "cobraparse.ml"
               : 'expr))
; (fun __caml_parser_env ->
    let _1 = (Parsing.peek_val __caml_parser_env 2 : 'expr) in
    let _3 = (Parsing.peek_val __caml_parser_env 0 : 'expr) in
    Obj.repr(
# 101 "cobraparse.mly"
                     ( Binop(_1, Add,   _3)   )
# 429 "cobraparse.ml"
               : 'expr))
; (fun __caml_parser_env ->
    let _1 = (Parsing.peek_val __caml_parser_env 2 : 'expr) in
    let _3 = (Parsing.peek_val __caml_parser_env 0 : 'expr) in
    Obj.repr(
# 102 "cobraparse.mly"
                     ( Binop(_1, Sub,   _3)   )
# 437 "cobraparse.ml"
               : 'expr))
; (fun __caml_parser_env ->
    let _1 = (Parsing.peek_val __caml_parser_env 2 : 'expr) in
    let _3 = (Parsing.peek_val __caml_parser_env 0 : 'expr) in
    Obj.repr(
# 103 "cobraparse.mly"
                     ( Binop(_1, Equal, _3)   )
# 445 "cobraparse.ml"
               : 'expr))
; (fun __caml_parser_env ->
    let _1 = (Parsing.peek_val __caml_parser_env 2 : 'expr) in
    let _3 = (Parsing.peek_val __caml_parser_env 0 : 'expr) in
    Obj.repr(
# 104 "cobraparse.mly"
                     ( Binop(_1, Neq, _3)     )
# 453 "cobraparse.ml"
               : 'expr))
; (fun __caml_parser_env ->
    let _1 = (Parsing.peek_val __caml_parser_env 2 : 'expr) in
    let _3 = (Parsing.peek_val __caml_parser_env 0 : 'expr) in
    Obj.repr(
# 105 "cobraparse.mly"
                     ( Binop(_1, Less,  _3)   )
# 461 "cobraparse.ml"
               : 'expr))
; (fun __caml_parser_env ->
    let _1 = (Parsing.peek_val __caml_parser_env 2 : 'expr) in
    let _3 = (Parsing.peek_val __caml_parser_env 0 : 'expr) in
    Obj.repr(
# 106 "cobraparse.mly"
                     ( Binop(_1, And,   _3)   )
# 469 "cobraparse.ml"
               : 'expr))
; (fun __caml_parser_env ->
    let _1 = (Parsing.peek_val __caml_parser_env 2 : 'expr) in
    let _3 = (Parsing.peek_val __caml_parser_env 0 : 'expr) in
    Obj.repr(
# 107 "cobraparse.mly"
                     ( Binop(_1, Or,    _3)   )
# 477 "cobraparse.ml"
               : 'expr))
; (fun __caml_parser_env ->
    let _1 = (Parsing.peek_val __caml_parser_env 2 : string) in
    let _3 = (Parsing.peek_val __caml_parser_env 0 : 'expr) in
    Obj.repr(
# 108 "cobraparse.mly"
                     ( Assign(_1, _3)         )
# 485 "cobraparse.ml"
               : 'expr))
; (fun __caml_parser_env ->
    let _2 = (Parsing.peek_val __caml_parser_env 1 : 'expr) in
    Obj.repr(
# 109 "cobraparse.mly"
                       ( _2                   )
# 492 "cobraparse.ml"
               : 'expr))
; (fun __caml_parser_env ->
    let _1 = (Parsing.peek_val __caml_parser_env 3 : string) in
    let _3 = (Parsing.peek_val __caml_parser_env 1 : 'args_opt) in
    Obj.repr(
# 111 "cobraparse.mly"
                              ( Call (_1, _3)  )
# 500 "cobraparse.ml"
               : 'expr))
; (fun __caml_parser_env ->
    Obj.repr(
# 115 "cobraparse.mly"
              ( [] )
# 506 "cobraparse.ml"
               : 'args_opt))
; (fun __caml_parser_env ->
    let _1 = (Parsing.peek_val __caml_parser_env 0 : 'args) in
    Obj.repr(
# 116 "cobraparse.mly"
         ( _1 )
# 513 "cobraparse.ml"
               : 'args_opt))
; (fun __caml_parser_env ->
    let _1 = (Parsing.peek_val __caml_parser_env 0 : 'expr) in
    Obj.repr(
# 119 "cobraparse.mly"
        ( [_1] )
# 520 "cobraparse.ml"
               : 'args))
; (fun __caml_parser_env ->
    let _1 = (Parsing.peek_val __caml_parser_env 2 : 'expr) in
    let _3 = (Parsing.peek_val __caml_parser_env 0 : 'args) in
    Obj.repr(
# 120 "cobraparse.mly"
                    ( _1::_3 )
# 528 "cobraparse.ml"
               : 'args))
(* Entry program *)
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
let program (lexfun : Lexing.lexbuf -> token) (lexbuf : Lexing.lexbuf) =
   (Parsing.yyparse yytables 1 lexfun lexbuf : Ast.program)
