type operator = Add | Sub | Mul | Div

type value =
  | IntValue of int
  | BoolValue of bool

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
