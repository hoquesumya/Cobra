open Ast

type sexpr = typ * expr_detail
and expr_detail =
  | SLiteral of int
  | SBoolLit of bool
  | SVar of string
  | SBinop of sexpr * bop * sexpr
  | SUnop of uop * sexpr
  | SAssign of typ option * sexpr * sexpr
  | SCall of string * sexpr list
  | Ref of sexpr
  | Deref of sexpr 
  | ObjectCall of sexpr * string * sexpr list
  | MemoryOp of sexpr * memoryOp

type sclass_decl = {
  sclass_name: string;
  ssuperclass: string option;
  sclass_body: sblock;
}

and sstmt =
  | SExpr of sexpr
  | SIf of sexpr * sblock * sblock option
  | SWhile of sexpr * sblock
  | SReturn of sexpr
  | SFunction of string * param list * typ option * sblock
  | SDecl of typ option * string
  | SClassDecl of sclass_decl

and sblock = SBlock of sstmt list  (* Define Block as a distinct type wrapping a list of statements *)

type sprogram = {
  locals: (typ * string) list;
  body: sblock;
}