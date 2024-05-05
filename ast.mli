type bop =
  | Add
  | Sub
  | Equal
  | Neq
  | Less
  | Greater
  | LessEq
  | GreaterEq
  | Mul

type typ =
  | Int
  | Bool

type id_catg = Id of string | PointerID of string
type mem_type = Dref | Address_of | Retain
type mem_ref = Release | Makeman

type expr1=
  Var1 of string
  | Binop1 of expr1 * bop * expr1
  | Literal1 of int
  |  Memory_handler1 of mem_type * expr1

type expr =
  | Literal of int
  | BoolLit of bool
  | Var of string
  | Binop of expr * bop * expr
  | Assign of string * expr
  | AssignVar of typ * id_catg * expr
  | Call of string * expr list
  | Memory_handler of mem_type * expr1
  | Memory_handler' of mem_type * expr
  | AssignPointer of mem_type * expr1 * expr
  | Method of expr * string * expr list
  | Init_class of string * string * expr

type stmt =
  | Expr of expr
  | If of expr * stmt list * (stmt list option)
  | While of expr * stmt list
  | Return of expr
  | Function of string * string list * stmt list
  | Class of string * string list * stmt list
  | Break 
  | Continue
  | Memory_ref of mem_ref * string


type program = {
  locals: (typ * string) list;
  body: stmt list;
}
