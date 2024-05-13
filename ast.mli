type bop =
  | Add
  | Sub
  | Mult
  | Div
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

type memoryOp =
  | Release
  | AutoRelease
  | Retain

type expr =
  | Literal of int
  | BoolLit of bool
  | Var of string
  | Binop of expr * bop * expr
  | Unop of uop * expr
  | Assign of typ option * expr * expr
  | Call of string * expr list
  | Ref of expr
  | Deref of expr 
  | ObjectCall of expr * string * expr list
  | MemoryOp of expr * memoryOp

type param = {
  param_type : typ option;
  param_name : string;
}

type class_decl = {
  class_name: string;
  superclass: string option;
  class_body: block;
}

and stmt =
  | Expr of expr
  | If of expr * block * block option
  | While of expr * block
  | Return of expr
  | Function of string * param list * typ option * block
  | Decl of typ option * string
  | ClassDecl of class_decl

and block = Block of stmt list  (* Define Block as a distinct type wrapping a list of statements *)

type program = {
  locals: (typ * string) list;
  body: block;
}
