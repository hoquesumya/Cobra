type bop =
  | Add
  | Sub
  | Mult
  | Div
  | Assign
  | Equal
  | Neq
  | Less
  | Greater
  | LessEq
  | GreaterEq

type uop =
  | Negate

type typ =
  | Int
  | Bool
  | IntPtr
  | BoolPtr

type expr =
  | Literal of int
  | BoolLit of bool
  | Var of string
  | Binop of expr * bop * expr
  | Unop of uop * expr
  | Assign of typ option * string * expr
  | Call of string * expr list
  | Ref of expr
  | Deref of expr 

type param = {
  param_type : typ option;
  param_name : string;
}

type stmt =
  | Expr of expr
  | If of expr * block * block option
  | While of expr * block
  | Return of expr
  | Function of string * param list * block
  | Decl of typ option * string

and block = Block of stmt list  (* Define Block as a distinct type wrapping a list of statements *)

type program = {
  locals: (typ * string) list;
  body: block;
}
