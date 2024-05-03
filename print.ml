open Ast

let string_of_op = function
  | Add -> "+"
  | Sub -> "-"
  | Equal -> "=="
  | Neq -> "!="
  | Less -> "<"
  | Greater -> ">"
  | LessEq -> "<="
  | GreaterEq -> ">="
  | Assign -> "="
  | Mul -> "*"

let string_of_memory = function
 | Dref ->"*"
 | Address_of -> "&"
 | Retain ->"retain"

let string_of_typ = function
  | Int -> "int"
  | Bool -> "bool"


let string_of_id = function 
  | Id (v) -> v
  | PointerID (v) -> "* "^v

let rec string_of_expr = function
  | Literal(l) -> string_of_int l
  | BoolLit(true) -> "true"
  | BoolLit(false) -> "false"
  | Var(s) -> s
  | Binop(e1, o, e2) -> string_of_expr e1 ^ " " ^ string_of_op o ^ " " ^ string_of_expr e2
  | Assign(v, e) -> v ^ " = " ^ string_of_expr e
  | AssignVar (t,v, e) -> string_of_typ t  ^ " "^ string_of_id v ^ " = " ^ string_of_expr e
  | Call(func, args) -> func ^ "(" ^ String.concat ", " (List.map string_of_expr args) ^ ")"
  | Memory_handler (m,e) ->  string_of_memory m ^ string_of_expr e
  | AssignPointer (e1,e2) -> "*" ^ string_of_expr e1 ^"= "^ string_of_expr e2


let rec string_of_stmt = function
  | Expr(expr) -> string_of_expr expr ^ ";"
  | If(e, s1, None) -> "if " ^ string_of_expr e ^ ":\n" ^ string_of_stmts s1
  | If(e, s1, Some s2) ->
    "if " ^ string_of_expr e ^ ":\n" ^ string_of_stmts s1 ^ "else:\n" ^ string_of_stmts s2
  | While(e, s) -> "while " ^ string_of_expr e ^ ":\n" ^ string_of_stmts s
  | Return(expr) -> "return " ^ string_of_expr expr ^ ";"
  | Function(name, params, body) -> "def " ^ name ^ "(" ^ String.concat ", " params ^ "):\n" ^ string_of_stmts body
  | Break -> "break"
  | Continue -> "continue"

and string_of_stmts stmts =
  String.concat "\n" (List.map string_of_stmt stmts)

let string_of_typ = function
  | Int -> "int"
  | Bool -> "bool"

let string_of_vdecl (t, id) = string_of_typ t ^ " " ^ id ^ ";"

let string_of_program fdecl =
  "Parsed program:\n" ^
  String.concat "\n" (List.map string_of_vdecl fdecl.locals) ^
  "\n" ^ string_of_stmts fdecl.body ^ "\n"
