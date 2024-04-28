(* Type definitions for binary operations *)
type bop =
  | Add
  | Sub
  | Assign
  | Equal
  | Neq
  | Less
  | Greater

(* Types for literals and basic types *)
type typ =
  | Int
  | Bool

(* Expression types *)
type expr =
  | Literal of int
  | BoolLit of bool
  | Var of string
  | Binop of expr * bop * expr
  | Assign of expr * expr

(* Statement types *)
type stmt =
  | Expr of expr
  | If of expr * stmt list * (stmt list option)  (* Optional else branch *)
  | While of expr * stmt list
  | Return of expr
  | Function of string * string list * stmt list  (* Function(name, params, body) *)

(* Program type to wrap the whole AST *)
type program = {
  locals: (typ * string) list;  (* Variable declarations - may not be needed based on the provided parser *)
  body: stmt list;              (* List of statements comprising the main body of the program *)
}
