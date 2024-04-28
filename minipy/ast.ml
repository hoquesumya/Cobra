
type binop =  Eq | Neq | Lt | Gt | Plus | Minus| Times | Divide |Exp | Lteq| Rteq| Or | And | Mod
type expr=
| Literal of int
| Float_literal of float
| Blit of bool
| Stirng_literal of string
| Variable of string
| Assign of  string * expr
| Binop of expr * binop * expr



type stmt = 
Expr of expr
(*| Elif of elif_block list*)
| Block of stmt list
| If of expr * stmt * stmt
| While of expr * stmt


type program = stmt list

let string_of_op = function
    Plus -> "+"
  | Minus -> "-"
  | Eq -> "=="
  | Neq -> "!="
  | Lt -> "<"
  | Gt -> ">"
  | And -> "&&"
  | Or -> "||"
  | Times -> "*"
  | Divide -> "/"

let rec string_of_expr = function
 Literal (l) -> string_of_int l
| Blit (true) -> "true"
| Blit (false) -> "false"
| Variable (x) -> x
| Binop (e1, op, e2) -> string_of_expr e1 ^ " " ^ string_of_op op ^ " " ^ string_of_expr e2
| Assign (v,e) -> v ^ " = " ^ string_of_expr e

let rec string_of_stmt = function 
Block(stmts) -> String.concat "\n" (List.map string_of_stmt stmts) ^ "\n"
| If (e, s1, s2) -> "if " ^ string_of_expr e ^ ":\n" ^ string_of_stmt s1 ^ "else:\n" ^ string_of_stmt s2
| While (e, s) ->  "while " ^ string_of_expr e ^ ":\n" ^ string_of_stmt s
| Expr(e) -> string_of_expr e

and string_of_program p = String.concat "" (List.map string_of_stmt p) ^ "\n\n"


