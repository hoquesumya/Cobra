type operator = Add | Sub | Mul | Div

type value =
  | IntValue of int
  | BoolValue of bool
  | VoidValue

type expr =
    Binop of expr * operator * expr
  | Lit of int
  | BoolLit of bool
  | Seq of expr * expr
  | Asn of string * expr
  | Var of string
  | And of expr * expr
  | Or of expr * expr
  | Not of expr
  | Eq of expr * expr
  | Neq of expr * expr
  | FunDef of string * expr list
  | SeqList of expr list
  | FunCall of string
