open Ast
open Sast

let string_of_op = function
  | Add -> "+"
  | Sub -> "-"
  | Mult -> "*"
  | Div -> "/"
  | Equal -> "=="
  | Neq -> "!="
  | Less -> "<"
  | Greater -> ">"
  | LessEq -> "<="
  | GreaterEq -> ">="
  | _ -> "="

let string_of_uop = function
  | Negate -> "-"

let rec string_of_expr = function
  | Literal(l) -> string_of_int l
  | BoolLit(true) -> "true"
  | BoolLit(false) -> "false"
  | Var(s) -> s
  | Binop(e1, o, e2) ->
      "(" ^ string_of_expr e1 ^ " " ^ string_of_op o ^ " " ^ string_of_expr e2 ^ ")"
  | Unop(o, e) -> string_of_uop o ^ "(" ^ string_of_expr e ^ ")"  (* Unary operation with parenthesis for clarity *)
  | Assign(v, e) -> v ^ " = " ^ string_of_expr e
  | Call(func, args) ->
      func ^ "(" ^ String.concat ", " (List.map string_of_expr args) ^ ")"

let indent_lines indent text =
  let prefix = String.make (2 * indent) ' ' in
  String.concat "\n" (List.map (fun line -> prefix ^ line) (String.split_on_char '\n' text))

let rec string_of_stmt indent = function
  | Expr(expr) -> indent_lines indent (string_of_expr expr ^ ";")
  | If(e, s1, None) ->
    indent_lines indent ("if " ^ string_of_expr e ^ ":") ^ "\n" ^
    string_of_stmts (indent + 1) s1
  | If(e, s1, Some s2) ->
    indent_lines indent ("if " ^ string_of_expr e ^ ":") ^ "\n" ^
    string_of_stmts (indent + 1) s1 ^ "\n" ^
    indent_lines indent "else:" ^ "\n" ^
    string_of_stmts (indent + 1) s2
  | While(e, s) ->
    indent_lines indent ("while " ^ string_of_expr e ^ ":") ^ "\n" ^
    string_of_stmts (indent + 1) s
  | Return(expr) -> indent_lines indent ("return " ^ string_of_expr expr ^ ";")
  | Function(name, params, body) ->
    indent_lines indent ("def " ^ name ^ "(" ^ String.concat ", " params ^ "):") ^ "\n" ^
    string_of_stmts (indent + 1) body

and string_of_stmts indent block =
  match block with
  | Block(stmts) -> String.concat "\n" (List.map (string_of_stmt indent) stmts)

let string_of_typ = function
  | Int -> "int"
  | Bool -> "bool"

let string_of_vdecl (t, id) = string_of_typ t ^ " " ^ id ^ ";"

let string_of_program fdecl =
  "Parsed program:\n" ^
  String.concat "\n" (List.map string_of_vdecl fdecl.locals) ^
  "\n" ^ string_of_stmts 0 fdecl.body ^ "\n"


(* sast.ml *)
let rec string_of_sexpr (t, e) = 
  string_of_typ t ^ " : " ^ (match e with
    | SLiteral(l) -> string_of_int l
    | SBoolLit(true) -> "true"
    | SBoolLit(false) -> "false"
    | SVar(s) -> s
    | SBinop(e1, o, e2) ->
        "(" ^ string_of_sexpr e1 ^ " " ^ string_of_op o ^ " " ^ string_of_sexpr e2 ^ ")"
    | SUnop(o, e) -> string_of_uop o ^ "(" ^ string_of_sexpr e ^ ")"  (* Unary operation with parenthesis for clarity *)
    | SAssign(v, e) -> v ^ " = " ^ string_of_sexpr e
    | SCall(func, args) ->
        func ^ "(" ^ String.concat ", " (List.map string_of_sexpr args) ^ ")")

let rec string_of_sstmt indent = function
  | SExpr(expr) -> indent_lines indent (string_of_sexpr expr ^ ";")
  | SIf(e, s1, None) ->
    indent_lines indent ("if " ^ string_of_sexpr e ^ ":") ^ "\n" ^
    string_of_sstmts (indent + 1) s1
  | SIf(e, s1, Some s2) ->
    indent_lines indent ("if " ^ string_of_sexpr e ^ ":") ^ "\n" ^
    string_of_sstmts (indent + 1) s1 ^ "\n" ^
    indent_lines indent "else:" ^ "\n" ^
    string_of_sstmts (indent + 1) s2
  | SWhile(e, s) ->
    indent_lines indent ("while " ^ string_of_sexpr e ^ ":") ^ "\n" ^
    string_of_sstmts (indent + 1) s
  | SReturn(expr) -> indent_lines indent ("return " ^ string_of_sexpr expr ^ ";")
  | SFunction(name, params, body) ->
    indent_lines indent ("def " ^ name ^ "(" ^ String.concat ", " params ^ "):") ^ "\n" ^
    string_of_sstmts (indent + 1) body

and string_of_sstmts indent block =
  match block with
  | SBlock(stmts) -> String.concat "\n" (List.map (string_of_sstmt indent) stmts)

let string_of_sprogram fdecl =
  "Parsed program:\n" ^
  String.concat "\n" (List.map string_of_vdecl fdecl.slocals) ^
  "\n" ^ string_of_sstmts 0 fdecl.sbody ^ "\n"


