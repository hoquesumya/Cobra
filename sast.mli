open Ast

type sexpr = typ * expr_detail
and expr_detail =
  | SLiteral of int
  | SBoolLit of bool
  | SVar of string
  | SBinop of sexpr * bop * sexpr
  | SUnop of uop * sexpr
  | SAssign of string * sexpr
  | SCall of string * sexpr list

type sstmt =
  | SExpr of sexpr
  | SIf of sexpr * sblock * sblock option
  | SWhile of sexpr * sblock
  | SReturn of sexpr
  | SFunction of string * string list * sblock

and sblock = SBlock of sstmt list

type sprogram = {
  slocals: (typ * string) list;
  sbody: sblock;
}
