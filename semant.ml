open Ast
open Sast
open Print

module StringMap = Map.Make(String)

(* Heavily based off micoc's semant.ml file, provided in class. *)
(* Function definition and calling check not implemented *)

let check (locals, body) = 
  let symbols = List.fold_left (fun m (ty, name) -> StringMap.add name ty m)
      StringMap.empty (locals)
  in
  let type_of_identifier s =
    try StringMap.find s symbols
    (*with Not_found -> raise (Failure ("undeclared identifier " ^ s))*)
    with Not_found -> Int
  in
  let rec check_expr = function
    | Literal l -> (Int, SLiteral l)
    | BoolLit l -> (Bool, SBoolLit l)
    | Var v -> (type_of_identifier v, SVar v)
    | Assign(None, e1, e2) ->
        let (t1, e1') = check_expr e1 
        and (t2, e2') = check_expr e2 in
        let err = "illegal assignment " ^ string_of_typ t1 ^ " = " ^
                  string_of_typ t2 ^ " in " ^ string_of_expr e2
        in
        (*if t1 = t2 then*)
        (t1, SAssign(None, (t1, e1'), (t2, e2')))
        (*else raise (Failure err)*)
    | Assign(Some ty, e1, e2) as ex ->
      let (t1, e1') = check_expr e1 
      and (t2, e2') = check_expr e2 in
      let err = "illegal assignment " ^ string_of_typ t1 ^ " = " ^
                  string_of_typ t2 ^ " in " ^ string_of_expr e2
      in
      if (ty = t2) (*&& (t1 = t2)*) then
        (t1, SAssign(Some ty, (t1, e1'), (t2, e2')))
      else raise (Failure err)
    | Unop(op, e) -> 
      let (t, e') = check_expr e in
      let err = "illegal unary operator " ^ string_of_typ t ^ " " ^
                  string_of_uop op ^ " in " ^ string_of_expr e
      in
      if t = Int then
        (t, SUnop(op, (t, e')))
      else raise (Failure err)
    | Binop(e1, op, e2) as e -> 
      let (t1, e1') = check_expr e1
      and (t2, e2') = check_expr e2 in
      let err = "illegal binary operator " ^
                  string_of_typ t1 ^ " " ^ string_of_bop op ^ " " ^
                  string_of_typ t2 ^ " in " ^ string_of_expr e
        in
        (* All binary operators require operands of the same type*)
        if t1 = t2 then
          (* Determine expression type based on operator and operand types *)
          let t = match op with
              Add | Sub | Mult | Div when t1 = Int -> Int
            | Equal | Neq -> Bool
            | Less | Greater | LessEq | GreaterEq when t1 = Int -> Bool
            | _ -> raise (Failure err)
          in
          (t, SBinop((t1, e1'), op, (t2, e2')))
        else raise (Failure err)
    | Call(fname, args) as call -> (Int, SCall(fname, List.map check_expr args))
  in
  let check_bool_expr e =
    let (t, e') = check_expr e in 
    match t with 
    | Bool -> (t, e')
    | _ -> 
      let err = "Expected bool expression in: " ^ string_of_expr e
      in raise (Failure err)
  in
  let rec check_stmt = function
    | Expr e -> SExpr (check_expr e)
    | If(e, b, None) -> SIf(check_bool_expr e, check_block b, None)
    | If(e, b, Some c) -> SIf(check_bool_expr e, check_block b, Some (check_block c))
    | While(e, st) -> 
      SWhile(check_bool_expr e, check_block st)
    | Return(e) -> SReturn(check_expr e)
    | Function(name, params, None, block) -> SFunction(name, params, None, check_block block)
    | Function(name, params, Some typ, block) -> SFunction(name, params, Some typ, check_block block)
  and check_block = function
    | Block(stmts) -> SBlock(List.map check_stmt stmts)
    | _ -> raise (Failure "Expected block in function body")
  in
  { slocals = locals; sbody = check_block body }

