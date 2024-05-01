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
  | If of expr * stmt list * (stmt list option)
  | While of expr * stmt list
  | Return of expr
  | Function of string * string list * stmt list

type program = {
  locals: (typ * string) list;
  body: stmt list;
}
