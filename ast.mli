type bop =
  | Add
  | Sub
  | Assign
  | Equal
  | Neq
  | Less
  | Greater
  | LessEq
  | GreaterEq

type typ =
  | Int
  | Bool

type expr =
  | Literal of int
  | BoolLit of bool
  | Var of string
  | Binop of expr * bop * expr
  | Assign of string * expr
  | Call of string * expr list

type stmt =
  | Expr of expr
  | If of expr * block * block option
  | While of expr * block
  | Return of expr
  | Function of string * string list * block

and block = Block of stmt list  (* Define Block as a distinct type wrapping a list of statements *)

type program = {
  locals: (typ * string) list;
  body: block;
}
