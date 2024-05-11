open Ast
open Sast

module StringMap = Map.Make(String)

(*Heavily based off micoc's semant.ml file, provided in class.*)

let check (locals, body) = 

  (* local check binds *)
  (* check function *)
  let check_bool_expr

  in
  
  let check_assign = 

  in

  (*TO DO STILL*)
  let type_of_identifier = function
    | Var v -> (StringMap.find v locals, SVar v)

  let check_expr = function
      Literal l -> (Int, SLiteral l)
    | BoolLit l -> (Bool, SBoolLit l)
    | Var v -> (type_of_identifier v, SVar v)
    | Assign(var, e) as ex ->
      let lt = type_of_identifier var
      and (rt, e') = check_expr e in 
      let err = "illegal assignment " ^ string_of_typ lt ^ " = " ^
                  string_of_typ rt ^ " in " ^ string_of_expr ex
      in
        (check_assign lt rt err, SAssign(var, (rt, e')))
    | Unop(op, e) -> 
      let (t, e') = check_expr e in
      let err = "illegal unary operator " ^ string_of_typ t ^ " " ^
                  string_of_op op ^ " in " ^ string_of_expr e
      in
      if t = Int then
        (t, SUnop(op, e'))
      else raise (Failure err)
    | Binop(e1, op, e2) as e -> 
      let (t1, e1') = check_expr e1
      and (t2, e2') = check_expr e2 in
      let err = "illegal binary operator " ^
                  string_of_typ t1 ^ " " ^ string_of_op op ^ " " ^
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
    | Call(fname, args) -> 

  in

  let check_function 

  in

  let check_stmt = function
    | Expr e -> SExpr (check_expr e)
    | If(e, b, bOPTION) IDK HOW TO DEAL W THIS
    | While(e, st) -> 
      SWhile(check_bool_expr e, check_stmt st)
    | Return(e) -> SReturn(check_expr e)
    | Function(fname, fargs, def) -> check_function fname fargs def FIX THIS

  in
  let body_stmts = 
    
  in
  (locals, List.map check_stmt body_stmts)


