open Ast

let rec string_of_expr = function
  | Int(n) -> string_of_int n
  | Var(v) -> v
  | Call(f, args) -> f ^ "(" ^ String.concat ", " (List.map string_of_expr args) ^ ")"

let rec string_of_stmt = function
  | Expr(expr) -> string_of_expr expr
  | If(cond, then_branch, else_branch) ->
    "if " ^ string_of_expr cond ^ "\n" ^ string_of_stmt then_branch ^
    (match else_branch with
     | None -> ""
     | Some(stmt) -> "\nelse\n" ^ string_of_stmt stmt)
  | Assign(var, expr) -> var ^ " = " ^ string_of_expr expr
  | Function(name, params, body) ->
    "def " ^ name ^ "(" ^ String.concat ", " params ^ ")\n" ^
    String.concat "\n" (List.map string_of_stmt body)

let string_of_program program =
  String.concat "\n" (List.map string_of_stmt program)

let print_ast program =
  print_endline (string_of_program program)
