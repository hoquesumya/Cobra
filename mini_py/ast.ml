type expr =
  | Int of int
  | Var of string
  | FunctionCall of string * expr list

type stmt =
  | Expr of expr
  | Print of expr
  | If of expr * stmt list * stmt list
  | FunctionDef of string * string list * stmt list

type program = stmt list

let rec string_of_expr = function
  | Int x -> string_of_int x
  | Var x -> x
  | FunctionCall(f, args) -> f ^ "(" ^ String.concat ", " (List.map string_of_expr args) ^ ")"

let rec string_of_stmt = function
  | Expr expr -> string_of_expr expr ^ ";"
  | Print expr -> "print(" ^ string_of_expr expr ^ ");"
  | If(cond, thn, els) ->
      "if (" ^ string_of_expr cond ^ ") {\n" ^
      String.concat "\n" (List.map string_of_stmt thn) ^ "\n} else {\n" ^
      String.concat "\n" (List.map string_of_stmt els) ^ "\n}"
  | FunctionDef(name, params, body) ->
      "def " ^ name ^ "(" ^ String.concat ", " params ^ ") {\n" ^
      String.concat "\n" (List.map string_of_stmt body) ^ "\n}"
