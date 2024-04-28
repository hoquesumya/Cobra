open Ast

(* Pretty-printing functions *)
let string_of_op = function
  | Add -> "+"
  | Sub -> "-"
  | Equal -> "=="
  | Neq -> "!="
  | Less -> "<"
  | Greater -> ">"
  | Assign -> "="

let rec string_of_expr = function
  | Literal(l) -> string_of_int l
  | BoolLit(true) -> "true"
  | BoolLit(false) -> "false"
  | Var(s) -> s
  | Binop(e1, o, e2) ->
    string_of_expr e1 ^ " " ^ string_of_op o ^ " " ^ string_of_expr e2
  | Assign(v, e) -> string_of_expr v ^ " = " ^ string_of_expr e

let rec string_of_stmt = function
  | Expr(expr) -> string_of_expr expr ^ "\n"
  | If(e, s1, None) ->
    "if " ^ string_of_expr e ^ ":\n" ^ string_of_stmts s1
  | If(e, s1, Some s2) ->
    "if " ^ string_of_expr e ^ ":\n" ^ string_of_stmts s1 ^
    "else:\n" ^ string_of_stmts s2
  | While(e, s) ->
    "while " ^ string_of_expr e ^ ":\n" ^ string_of_stmts s
  | Return(expr) -> "return " ^ string_of_expr expr ^ "\n"
  | Function(name, params, body) ->
    "def " ^ name ^ "(" ^ String.concat ", " params ^ "):\n" ^ string_of_stmts body
and string_of_stmts stmts =
  String.concat "\n" (List.map string_of_stmt stmts) ^ "\n"


let string_of_typ = function
  | Int -> "int"
  | Bool -> "bool"

let string_of_vdecl (t, id) = string_of_typ t ^ " " ^ id ^ "\n"

let string_of_program fdecl =
  "\n\nParsed program: \n\n" ^
  String.concat "" (List.map string_of_vdecl fdecl.locals) ^
  String.concat "" (List.map string_of_stmt fdecl.body) ^
  "\n"

let _ =
  let lexbuf = Lexing.from_channel stdin in
  let program = Parser.program_rule Scanner.token lexbuf in
  print_endline (string_of_program program)
