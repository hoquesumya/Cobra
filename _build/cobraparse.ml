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
# 30 "cobraparse.ml"
)
  | BLIT of (
# 13 "cobraparse.mly"
        bool
# 35 "cobraparse.ml"
)
  | ID of (
# 14 "cobraparse.mly"
        string
# 40 "cobraparse.ml"
)
  | EOF

open Parsing
let _ = parse_error;;
# 4 "cobraparse.mly"
open Ast
# 48 "cobraparse.ml"
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
  266 (* PLUS *);
  267 (* MINUS *);
  268 (* ASSIGN *);
  269 (* EQ *);
  270 (* NEQ *);
  271 (* LT *);
  272 (* AND *);
  273 (* OR *);
  274 (* IF *);
  275 (* ELSE *);
  276 (* WHILE *);
  277 (* INT *);
  278 (* BOOL *);
  279 (* RETURN *);
  280 (* COMMA *);
    0 (* EOF *);
    0|]

let yytransl_block = [|
  281 (* LITERAL *);
  282 (* BLIT *);
  283 (* ID *);
    0|]

let yylhs = "\255\255\
\001\000\002\000\002\000\002\000\005\000\005\000\003\000\006\000\
\006\000\004\000\007\000\007\000\009\000\009\000\008\000\008\000\
\010\000\010\000\010\000\010\000\010\000\011\000\011\000\011\000\
\011\000\011\000\011\000\011\000\011\000\011\000\011\000\011\000\
\011\000\011\000\012\000\012\000\013\000\013\000\000\000"

let yylen = "\002\000\
\002\000\000\000\003\000\003\000\000\000\003\000\002\000\001\000\
\001\000\012\000\000\000\001\000\001\000\003\000\000\000\003\000\
\001\000\004\000\007\000\005\000\002\000\001\000\001\000\001\000\
\003\000\003\000\003\000\003\000\003\000\003\000\003\000\003\000\
\003\000\004\000\000\000\001\000\001\000\003\000\002\000"

let yydefred = "\000\000\
\000\000\000\000\000\000\008\000\009\000\039\000\000\000\000\000\
\000\000\000\000\000\000\001\000\000\000\000\000\007\000\000\000\
\003\000\004\000\000\000\000\000\012\000\000\000\000\000\014\000\
\000\000\000\000\000\000\000\000\000\000\000\000\000\000\000\000\
\000\000\000\000\000\000\000\000\022\000\023\000\000\000\000\000\
\000\000\000\000\006\000\000\000\000\000\000\000\000\000\000\000\
\000\000\000\000\010\000\000\000\000\000\000\000\000\000\000\000\
\000\000\000\000\000\000\033\000\000\000\000\000\000\000\000\000\
\000\000\036\000\000\000\016\000\025\000\026\000\000\000\000\000\
\000\000\000\000\000\000\018\000\000\000\000\000\000\000\034\000\
\000\000\020\000\038\000\000\000\019\000"

let yydgoto = "\002\000\
\006\000\007\000\008\000\009\000\030\000\010\000\020\000\040\000\
\021\000\041\000\042\000\065\000\066\000"

let yysindex = "\002\000\
\070\255\000\000\002\255\000\000\000\000\000\000\013\000\038\255\
\040\255\010\255\041\255\000\000\070\255\070\255\000\000\242\254\
\000\000\000\000\021\255\045\255\000\000\242\254\042\255\000\000\
\242\254\056\255\057\255\242\254\065\255\036\255\242\254\007\255\
\074\255\075\255\087\255\007\255\000\000\000\000\004\255\077\255\
\101\255\172\255\000\000\134\255\036\255\007\255\007\255\172\255\
\007\255\007\255\000\000\036\255\007\255\007\255\007\255\007\255\
\007\255\007\255\007\255\000\000\103\255\143\255\152\255\160\255\
\102\255\000\000\172\255\000\000\000\000\000\000\193\255\193\255\
\069\255\187\255\180\255\000\000\036\255\036\255\007\255\000\000\
\093\255\000\000\000\000\036\255\000\000"

let yyrindex = "\000\000\
\106\000\000\000\000\000\000\000\000\000\000\000\000\000\000\000\
\000\000\000\000\000\000\000\000\106\000\106\000\000\000\112\255\
\000\000\000\000\123\255\000\000\000\000\000\000\000\000\000\000\
\000\000\000\000\000\000\026\255\000\000\124\255\026\255\000\000\
\000\000\000\000\000\000\000\000\000\000\000\000\054\255\000\000\
\000\000\000\255\000\000\000\000\124\255\000\000\000\000\001\255\
\125\255\000\000\000\000\124\255\000\000\000\000\000\000\000\000\
\000\000\000\000\000\000\000\000\000\000\000\000\000\000\128\255\
\000\000\000\000\117\255\000\000\000\000\000\000\080\255\097\255\
\071\255\106\255\100\255\000\000\000\000\000\000\000\000\000\000\
\000\000\000\000\000\000\000\000\000\000"

let yygindex = "\000\000\
\000\000\253\255\111\000\000\000\101\000\109\000\000\000\216\255\
\113\000\214\255\224\255\000\000\059\000"

let yytablesize = 208
let yytable = "\044\000\
\017\000\021\000\001\000\048\000\061\000\049\000\004\000\005\000\
\032\000\017\000\018\000\068\000\012\000\062\000\063\000\050\000\
\064\000\067\000\017\000\021\000\069\000\070\000\071\000\072\000\
\073\000\074\000\075\000\005\000\011\000\005\000\005\000\037\000\
\038\000\039\000\081\000\082\000\015\000\032\000\013\000\033\000\
\014\000\085\000\016\000\005\000\022\000\005\000\064\000\023\000\
\005\000\025\000\005\000\005\000\005\000\034\000\024\000\035\000\
\024\000\028\000\036\000\027\000\037\000\038\000\039\000\024\000\
\024\000\031\000\024\000\024\000\024\000\024\000\024\000\029\000\
\024\000\029\000\045\000\003\000\046\000\024\000\053\000\054\000\
\027\000\051\000\027\000\029\000\029\000\029\000\029\000\029\000\
\047\000\029\000\004\000\005\000\027\000\027\000\029\000\027\000\
\027\000\028\000\027\000\028\000\031\000\052\000\031\000\027\000\
\080\000\002\000\030\000\076\000\030\000\028\000\028\000\084\000\
\028\000\028\000\011\000\028\000\031\000\032\000\031\000\032\000\
\028\000\030\000\030\000\031\000\030\000\013\000\019\000\035\000\
\015\000\030\000\037\000\043\000\019\000\026\000\024\000\032\000\
\060\000\083\000\029\000\000\000\032\000\029\000\000\000\053\000\
\054\000\077\000\055\000\056\000\057\000\058\000\059\000\000\000\
\053\000\054\000\078\000\055\000\056\000\057\000\058\000\059\000\
\000\000\053\000\054\000\000\000\055\000\056\000\057\000\058\000\
\059\000\053\000\054\000\000\000\055\000\056\000\057\000\058\000\
\059\000\000\000\000\000\000\000\000\000\053\000\054\000\079\000\
\055\000\056\000\057\000\058\000\059\000\053\000\054\000\000\000\
\055\000\056\000\057\000\058\000\053\000\054\000\000\000\055\000\
\056\000\057\000\053\000\054\000\000\000\000\000\000\000\057\000"

let yycheck = "\032\000\
\001\001\001\001\001\000\036\000\045\000\002\001\021\001\022\001\
\002\001\013\000\014\000\052\000\000\000\046\000\047\000\012\001\
\049\000\050\000\019\001\019\001\053\000\054\000\055\000\056\000\
\057\000\058\000\059\000\002\001\027\001\004\001\005\001\025\001\
\026\001\027\001\077\000\078\000\027\001\002\001\001\001\004\001\
\001\001\084\000\002\001\018\001\024\001\020\001\079\000\003\001\
\023\001\008\001\025\001\026\001\027\001\018\001\001\001\020\001\
\003\001\001\001\023\001\004\001\025\001\026\001\027\001\010\001\
\011\001\001\001\013\001\014\001\015\001\016\001\017\001\001\001\
\019\001\003\001\001\001\006\001\002\001\024\001\010\001\011\001\
\001\001\005\001\003\001\013\001\014\001\015\001\016\001\017\001\
\002\001\019\001\021\001\022\001\013\001\014\001\024\001\016\001\
\017\001\001\001\019\001\003\001\001\001\001\001\003\001\024\001\
\003\001\000\000\001\001\005\001\003\001\013\001\014\001\019\001\
\016\001\017\001\003\001\019\001\017\001\001\001\019\001\003\001\
\024\001\016\001\017\001\024\001\019\001\003\001\016\000\003\001\
\005\001\024\001\003\001\031\000\022\000\025\000\022\000\019\001\
\003\001\079\000\028\000\255\255\024\001\031\000\255\255\010\001\
\011\001\003\001\013\001\014\001\015\001\016\001\017\001\255\255\
\010\001\011\001\003\001\013\001\014\001\015\001\016\001\017\001\
\255\255\010\001\011\001\255\255\013\001\014\001\015\001\016\001\
\017\001\010\001\011\001\255\255\013\001\014\001\015\001\016\001\
\017\001\255\255\255\255\255\255\255\255\010\001\011\001\024\001\
\013\001\014\001\015\001\016\001\017\001\010\001\011\001\255\255\
\013\001\014\001\015\001\016\001\010\001\011\001\255\255\013\001\
\014\001\015\001\010\001\011\001\255\255\255\255\255\255\015\001"

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
            ( _1 )
# 242 "cobraparse.ml"
               : Ast.program))
; (fun __caml_parser_env ->
    Obj.repr(
# 34 "cobraparse.mly"
                 ( ([], [])               )
# 248 "cobraparse.ml"
               : 'decls))
; (fun __caml_parser_env ->
    let _1 = (Parsing.peek_val __caml_parser_env 2 : 'vdecl) in
    let _3 = (Parsing.peek_val __caml_parser_env 0 : 'decls) in
    Obj.repr(
# 35 "cobraparse.mly"
                    ( ((_1 :: fst _3), snd _3) )
# 256 "cobraparse.ml"
               : 'decls))
; (fun __caml_parser_env ->
    let _1 = (Parsing.peek_val __caml_parser_env 2 : 'fdecl) in
    let _3 = (Parsing.peek_val __caml_parser_env 0 : 'decls) in
    Obj.repr(
# 36 "cobraparse.mly"
                    ( (fst _3, (_1 :: snd _3)) )
# 264 "cobraparse.ml"
               : 'decls))
; (fun __caml_parser_env ->
    Obj.repr(
# 39 "cobraparse.mly"
              ( print_endline "EMPTY VDECL LIST"; [] )
# 270 "cobraparse.ml"
               : 'vdecl_list))
; (fun __caml_parser_env ->
    let _1 = (Parsing.peek_val __caml_parser_env 2 : 'vdecl) in
    let _3 = (Parsing.peek_val __caml_parser_env 0 : 'vdecl_list) in
    Obj.repr(
# 40 "cobraparse.mly"
                           ( print_endline "VDECL LIST"; _1 :: _3 )
# 278 "cobraparse.ml"
               : 'vdecl_list))
; (fun __caml_parser_env ->
    let _1 = (Parsing.peek_val __caml_parser_env 1 : 'typ) in
    let _2 = (Parsing.peek_val __caml_parser_env 0 : string) in
    Obj.repr(
# 44 "cobraparse.mly"
         ( print_endline ("VDECL ID " ^ _2); (_1, _2) )
# 286 "cobraparse.ml"
               : 'vdecl))
; (fun __caml_parser_env ->
    Obj.repr(
# 47 "cobraparse.mly"
          ( print_endline "TYP"; Int   )
# 292 "cobraparse.ml"
               : 'typ))
; (fun __caml_parser_env ->
    Obj.repr(
# 48 "cobraparse.mly"
          ( Bool  )
# 298 "cobraparse.ml"
               : 'typ))
; (fun __caml_parser_env ->
    let _2 = (Parsing.peek_val __caml_parser_env 10 : string) in
    let _4 = (Parsing.peek_val __caml_parser_env 8 : 'formals_opt) in
    let _7 = (Parsing.peek_val __caml_parser_env 5 : 'typ) in
    let _10 = (Parsing.peek_val __caml_parser_env 2 : 'vdecl_list) in
    let _11 = (Parsing.peek_val __caml_parser_env 1 : 'stmt_list) in
    Obj.repr(
# 53 "cobraparse.mly"
  (
    print_endline "FUNC";
    {
      rtyp=_7;
      fname=_2;
      formals=_4;
      locals=_10;
      body=_11
    }
  )
# 318 "cobraparse.ml"
               : 'fdecl))
; (fun __caml_parser_env ->
    Obj.repr(
# 66 "cobraparse.mly"
              ( [] )
# 324 "cobraparse.ml"
               : 'formals_opt))
; (fun __caml_parser_env ->
    let _1 = (Parsing.peek_val __caml_parser_env 0 : 'formals_list) in
    Obj.repr(
# 67 "cobraparse.mly"
                 ( print_endline "FORMALS"; _1 )
# 331 "cobraparse.ml"
               : 'formals_opt))
; (fun __caml_parser_env ->
    let _1 = (Parsing.peek_val __caml_parser_env 0 : 'vdecl) in
    Obj.repr(
# 70 "cobraparse.mly"
        ( [_1] )
# 338 "cobraparse.ml"
               : 'formals_list))
; (fun __caml_parser_env ->
    let _1 = (Parsing.peek_val __caml_parser_env 2 : 'vdecl) in
    let _3 = (Parsing.peek_val __caml_parser_env 0 : 'formals_list) in
    Obj.repr(
# 71 "cobraparse.mly"
                             ( _1::_3 )
# 346 "cobraparse.ml"
               : 'formals_list))
; (fun __caml_parser_env ->
    Obj.repr(
# 74 "cobraparse.mly"
                ( [] )
# 352 "cobraparse.ml"
               : 'stmt_list))
; (fun __caml_parser_env ->
    let _1 = (Parsing.peek_val __caml_parser_env 2 : 'stmt) in
    let _3 = (Parsing.peek_val __caml_parser_env 0 : 'stmt_list) in
    Obj.repr(
# 75 "cobraparse.mly"
                         ( _1::_3 )
# 360 "cobraparse.ml"
               : 'stmt_list))
; (fun __caml_parser_env ->
    let _1 = (Parsing.peek_val __caml_parser_env 0 : 'expr) in
    Obj.repr(
# 78 "cobraparse.mly"
                                       ( Expr _1      )
# 367 "cobraparse.ml"
               : 'stmt))
; (fun __caml_parser_env ->
    let _3 = (Parsing.peek_val __caml_parser_env 1 : 'stmt_list) in
    Obj.repr(
# 79 "cobraparse.mly"
                                                 ( Block _3 )
# 374 "cobraparse.ml"
               : 'stmt))
; (fun __caml_parser_env ->
    let _3 = (Parsing.peek_val __caml_parser_env 4 : 'expr) in
    let _5 = (Parsing.peek_val __caml_parser_env 2 : 'stmt) in
    let _7 = (Parsing.peek_val __caml_parser_env 0 : 'stmt) in
    Obj.repr(
# 82 "cobraparse.mly"
                                            ( If(_3, _5, _7) )
# 383 "cobraparse.ml"
               : 'stmt))
; (fun __caml_parser_env ->
    let _3 = (Parsing.peek_val __caml_parser_env 2 : 'expr) in
    let _5 = (Parsing.peek_val __caml_parser_env 0 : 'stmt) in
    Obj.repr(
# 83 "cobraparse.mly"
                                            ( print_endline "WHILE"; While (_3, _5)  )
# 391 "cobraparse.ml"
               : 'stmt))
; (fun __caml_parser_env ->
    let _2 = (Parsing.peek_val __caml_parser_env 0 : 'expr) in
    Obj.repr(
# 85 "cobraparse.mly"
                                       ( print_endline "RETURN"; Return _2      )
# 398 "cobraparse.ml"
               : 'stmt))
; (fun __caml_parser_env ->
    let _1 = (Parsing.peek_val __caml_parser_env 0 : int) in
    Obj.repr(
# 88 "cobraparse.mly"
                     ( Literal(_1)            )
# 405 "cobraparse.ml"
               : 'expr))
; (fun __caml_parser_env ->
    let _1 = (Parsing.peek_val __caml_parser_env 0 : bool) in
    Obj.repr(
# 89 "cobraparse.mly"
                     ( BoolLit(_1)            )
# 412 "cobraparse.ml"
               : 'expr))
; (fun __caml_parser_env ->
    let _1 = (Parsing.peek_val __caml_parser_env 0 : string) in
    Obj.repr(
# 90 "cobraparse.mly"
                     ( Id(_1)                 )
# 419 "cobraparse.ml"
               : 'expr))
; (fun __caml_parser_env ->
    let _1 = (Parsing.peek_val __caml_parser_env 2 : 'expr) in
    let _3 = (Parsing.peek_val __caml_parser_env 0 : 'expr) in
    Obj.repr(
# 91 "cobraparse.mly"
                     ( Binop(_1, Add,   _3)   )
# 427 "cobraparse.ml"
               : 'expr))
; (fun __caml_parser_env ->
    let _1 = (Parsing.peek_val __caml_parser_env 2 : 'expr) in
    let _3 = (Parsing.peek_val __caml_parser_env 0 : 'expr) in
    Obj.repr(
# 92 "cobraparse.mly"
                     ( Binop(_1, Sub,   _3)   )
# 435 "cobraparse.ml"
               : 'expr))
; (fun __caml_parser_env ->
    let _1 = (Parsing.peek_val __caml_parser_env 2 : 'expr) in
    let _3 = (Parsing.peek_val __caml_parser_env 0 : 'expr) in
    Obj.repr(
# 93 "cobraparse.mly"
                     ( Binop(_1, Equal, _3)   )
# 443 "cobraparse.ml"
               : 'expr))
; (fun __caml_parser_env ->
    let _1 = (Parsing.peek_val __caml_parser_env 2 : 'expr) in
    let _3 = (Parsing.peek_val __caml_parser_env 0 : 'expr) in
    Obj.repr(
# 94 "cobraparse.mly"
                     ( Binop(_1, Neq, _3)     )
# 451 "cobraparse.ml"
               : 'expr))
; (fun __caml_parser_env ->
    let _1 = (Parsing.peek_val __caml_parser_env 2 : 'expr) in
    let _3 = (Parsing.peek_val __caml_parser_env 0 : 'expr) in
    Obj.repr(
# 95 "cobraparse.mly"
                     ( Binop(_1, Less,  _3)   )
# 459 "cobraparse.ml"
               : 'expr))
; (fun __caml_parser_env ->
    let _1 = (Parsing.peek_val __caml_parser_env 2 : 'expr) in
    let _3 = (Parsing.peek_val __caml_parser_env 0 : 'expr) in
    Obj.repr(
# 96 "cobraparse.mly"
                     ( Binop(_1, And,   _3)   )
# 467 "cobraparse.ml"
               : 'expr))
; (fun __caml_parser_env ->
    let _1 = (Parsing.peek_val __caml_parser_env 2 : 'expr) in
    let _3 = (Parsing.peek_val __caml_parser_env 0 : 'expr) in
    Obj.repr(
# 97 "cobraparse.mly"
                     ( Binop(_1, Or,    _3)   )
# 475 "cobraparse.ml"
               : 'expr))
; (fun __caml_parser_env ->
    let _1 = (Parsing.peek_val __caml_parser_env 2 : string) in
    let _3 = (Parsing.peek_val __caml_parser_env 0 : 'expr) in
    Obj.repr(
# 98 "cobraparse.mly"
                     ( Assign(_1, _3)         )
# 483 "cobraparse.ml"
               : 'expr))
; (fun __caml_parser_env ->
    let _2 = (Parsing.peek_val __caml_parser_env 1 : 'expr) in
    Obj.repr(
# 99 "cobraparse.mly"
                       ( _2                   )
# 490 "cobraparse.ml"
               : 'expr))
; (fun __caml_parser_env ->
    let _1 = (Parsing.peek_val __caml_parser_env 3 : string) in
    let _3 = (Parsing.peek_val __caml_parser_env 1 : 'args_opt) in
    Obj.repr(
# 101 "cobraparse.mly"
                              ( Call (_1, _3)  )
# 498 "cobraparse.ml"
               : 'expr))
; (fun __caml_parser_env ->
    Obj.repr(
# 105 "cobraparse.mly"
              ( [] )
# 504 "cobraparse.ml"
               : 'args_opt))
; (fun __caml_parser_env ->
    let _1 = (Parsing.peek_val __caml_parser_env 0 : 'args) in
    Obj.repr(
# 106 "cobraparse.mly"
         ( _1 )
# 511 "cobraparse.ml"
               : 'args_opt))
; (fun __caml_parser_env ->
    let _1 = (Parsing.peek_val __caml_parser_env 0 : 'expr) in
    Obj.repr(
# 109 "cobraparse.mly"
        ( [_1] )
# 518 "cobraparse.ml"
               : 'args))
; (fun __caml_parser_env ->
    let _1 = (Parsing.peek_val __caml_parser_env 2 : 'expr) in
    let _3 = (Parsing.peek_val __caml_parser_env 0 : 'args) in
    Obj.repr(
# 110 "cobraparse.mly"
                    ( _1::_3 )
# 526 "cobraparse.ml"
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
