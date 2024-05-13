open Ast
open Sast

(* String representation of binary operators *)
let string_of_bop = function
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

let string_of_typ = function
  | Int -> "int"
  | Bool -> "bool"
  | IntPtr -> "int*"
  | BoolPtr -> "bool*"

let string_of_uop = function
  | Negate -> "-"

let string_of_memory_op = function
| Release -> "release"
| AutoRelease -> "autorelease"
| Retain -> "retain"

let rec string_of_expr = function
  | Literal(l) -> string_of_int l
  | BoolLit(true) -> "true"
  | BoolLit(false) -> "false"
  | Var(s) -> s
  | Binop(e1, o, e2) ->
      "(" ^ string_of_expr e1 ^ " " ^ string_of_bop o ^ " " ^ string_of_expr e2 ^ ")"
  | Unop(o, e) -> string_of_uop o ^ "(" ^ string_of_expr e ^ ")"
  | Assign(ty_opt, v, e) ->
    let type_str = match ty_opt with
      | Some ty -> string_of_typ ty ^ " "
      | None -> ""  (* Optionally omit type or provide a default *)
    in
    string_of_expr v ^ " = " ^ type_str ^ string_of_expr e
  | Call(func, args) ->
      func ^ "(" ^ String.concat ", " (List.map string_of_expr args) ^ ")"
  | Ref(e) -> "(&" ^ string_of_expr e ^ ")"
  | Deref(e) -> "(*" ^ string_of_expr e ^ ")"
  | ObjectCall(obj, meth, args) ->
    string_of_expr obj ^ "." ^ meth ^ "(" ^ String.concat ", " (List.map string_of_expr args) ^ ")"
  | MemoryOp(obj, meth) ->
    string_of_memory_op meth ^ " " ^ string_of_expr obj

(* Helper function to indent lines for structured output *)
let indent_lines indent text =
  let prefix = String.make (2 * indent) ' ' in
  String.concat "\n" (List.map (fun line -> prefix ^ line) (String.split_on_char '\n' text))

(* Recursive function to construct string representation of statements *)
let rec string_of_stmt indent = function
  | Expr(expr) -> indent_lines indent (string_of_expr expr ^ ";\n")
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
  | Return(expr) -> indent_lines indent ("return " ^ string_of_expr expr ^ ";\n")
  | Function(name, params, rtyp, body) ->
    let params_str = params |> List.map (fun p ->
      match p.param_type with
      | Some ty -> string_of_typ ty ^ " " ^ p.param_name
      | None -> p.param_name  (* Omit type information if None *)
    ) |> String.concat ", " in
    let rtyp_str = match rtyp with
      | Some ty -> "->" ^ string_of_typ ty
      | None -> "" in
    indent_lines indent ("def " ^ name ^ "(" ^ params_str ^ ")" ^ rtyp_str ^ ":") ^ "\n" ^
    string_of_stmts (indent + 1) body
  | Decl(ty_opt, name) ->
    let type_str = match ty_opt with
      | Some ty -> string_of_typ ty ^ " "
      | None -> ""  (* Optionally omit type or provide a default *)
    in
    indent_lines indent (type_str ^ name ^ ";\n")
  | ClassDecl cd ->
    let superclass_str = match cd.superclass with
      | Some sc -> "(" ^ sc ^ ")"
      | None -> ""
    in
    indent_lines indent ("class " ^ cd.class_name ^ superclass_str ^ ":") ^ "\n" ^
    string_of_stmts (indent + 1) cd.class_body

(* String representation of blocks of statements *)
and string_of_stmts indent block =
  match block with
  | Block(stmts) -> String.concat "\n" (List.map (string_of_stmt indent) stmts)

let string_of_vdecl (t, id) = string_of_typ t ^ " " ^ id ^ ";\n"

let string_of_program fdecl =
  "Parsed program:\n" ^
  String.concat "\n" (List.map string_of_vdecl fdecl.locals) ^
  "\n" ^ string_of_stmts 0 fdecl.body ^ "\n"

(* ssast print *)

let rec string_of_sexpr (t, e) = 
  string_of_typ t ^ " : " ^ (match e with
    | SLiteral(l) -> string_of_int l
    | SBoolLit(true) -> "true"
    | SBoolLit(false) -> "false"
    | SVar(s) -> s
    | SBinop(e1, o, e2) ->
        "(" ^ string_of_sexpr e1 ^ " " ^ string_of_bop o ^ " " ^ string_of_sexpr e2 ^ ")"
    | SUnop(o, e) -> string_of_uop o ^ "(" ^ string_of_sexpr e ^ ")"  (* Unary operation with parenthesis for clarity *)
    | SAssign(ty_opt, v, e) ->
      let type_str = match ty_opt with
        | Some ty -> string_of_typ ty ^ " "
        | None -> ""  (* Optionally omit type or provide a default *)
      in
      string_of_sexpr v ^ " = " ^ type_str ^ string_of_sexpr e
    | SCall(func, args) ->
        func ^ "(" ^ String.concat ", " (List.map string_of_sexpr args) ^ ")"
    | SRef(e) -> "(&" ^ string_of_sexpr e ^ ")"
    | SDeref(e) ->  "(*" ^ string_of_sexpr e ^ ")"
    | SObjectCall(obj, meth, args) -> string_of_sexpr obj ^ "." ^ meth ^ "(" ^ String.concat ", " (List.map string_of_sexpr args) ^ ")"
    | SMemoryOp(obj, meth) -> string_of_memory_op meth ^ " " ^ string_of_sexpr obj)

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
  | SFunction(name, params, rtyp, body) ->
    let params_str = params |> List.map (fun p ->
      match p.param_type with
      | Some ty -> string_of_typ ty ^ " " ^ p.param_name
      | None -> p.param_name  (* Omit type information if None *)
    ) |> String.concat ", " in
    let rtyp_str = match rtyp with
      | Some ty -> "->" ^ string_of_typ ty
      | None -> "" in
    indent_lines indent ("def " ^ name ^ "(" ^ params_str ^ ")" ^ rtyp_str ^ ":") ^ "\n" ^
    string_of_sstmts (indent + 1) body
  | SDecl(ty_opt, name) ->
    let type_str = match ty_opt with
      | Some ty -> string_of_typ ty ^ " "
      | None -> ""  (* Optionally omit type or provide a default *)
    in
    indent_lines indent (type_str ^ name ^ ";\n")
  | SClassDecl cd ->
    let superclass_str = match cd.ssuperclass with
      | Some sc -> "(" ^ sc ^ ")"
      | None -> ""
    in
    indent_lines indent ("class " ^ cd.sclass_name ^ superclass_str ^ ":") ^ "\n" ^
    string_of_sstmts (indent + 1) cd.sclass_body

and string_of_sstmts indent block =
  match block with
  | SBlock(stmts) -> String.concat "\n" (List.map (string_of_sstmt indent) stmts)

let string_of_sprogram sfdecl =
  "Parsed program:\n" ^
  String.concat "\n" (List.map string_of_vdecl sfdecl.slocals) ^
  "\n" ^ string_of_sstmts 0 sfdecl.sbody ^ "\n"
