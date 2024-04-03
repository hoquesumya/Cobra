open Ast

module StringMap = Map.Make(String)

type func_def = string list * expr  (* Parameters and body *)
type environment = {
  vars: value StringMap.t;
  funcs: func_def StringMap.t;
}

let empty_env () = {
  vars = StringMap.empty;
  funcs = StringMap.empty;
}

exception ReturnException of value

let rec eval expr =
  let rec eval_e expr env : value * environment =
    match expr with
    | Lit n -> (IntValue n, env)
    | BoolLit b -> (BoolValue b, env)
    | Var x -> (StringMap.find x env.vars, env)
    | Asn (x, e) ->
      let (v, new_env) = eval_e e env in
      (v, {env with vars = StringMap.add x v new_env.vars})
    | Seq (e1, e2) ->
      let (_, env1) = eval_e e1 env in
      eval_e e2 env1
    | Binop (e1, op, e2) ->
      let (v1, env1) = eval_e e1 env in
      let (v2, env2) = eval_e e2 env1 in
      let result = match (v1, v2, op) with
        | (IntValue n1, IntValue n2, Add) -> IntValue (n1 + n2)
        | (IntValue n1, IntValue n2, Sub) -> IntValue (n1 - n2)
        | (IntValue n1, IntValue n2, Mul) -> IntValue (n1 * n2)
        | (IntValue n1, IntValue n2, Div) -> IntValue (n1 / n2)
        | _ -> failwith "Runtime type error: expected integer operands for binary operation"
      in
      (result, env2)
    | And (e1, e2) ->
      let eval_bool e env = match eval_e e env with
        | (BoolValue b, env') -> (b, env')
        | _ -> failwith "Runtime type error: expected boolean operands"
      in
      let (b1, env1) = eval_bool e1 env in
      let (b2, env2) = eval_bool e2 env1 in
      (BoolValue (b1 && b2), env2)
    | Or (e1, e2) ->
      let eval_bool e env = match eval_e e env with
        | (BoolValue b, env') -> (b, env')
        | _ -> failwith "Runtime type error: expected boolean operands"
      in
      let (b1, env1) = eval_bool e1 env in
      let (b2, env2) = eval_bool e2 env1 in
      (BoolValue (b1 || b2), env2)
    | Not (e1) ->
      let eval_bool e env = match eval_e e env with
      | (BoolValue b, env') -> (b, env')
      | _ -> failwith "Runtime type error: expected boolean operands"
      in
      let (b1, env1) = eval_bool e1 env in
      (BoolValue (not b1), env1)
    | Eq (e1, e2) ->
      let (v1, env1) = eval_e e1 env in
      let (v2, env2) = eval_e e2 env1 in
      (match (v1, v2) with
        | (IntValue n1, IntValue n2) -> (BoolValue (n1 = n2), env2)
        | (BoolValue b1, BoolValue b2) -> (BoolValue (b1 = b2), env2)
        | _ -> failwith "Runtime type error: incompatible operand types for equality check")
    | Neq (e1, e2) ->
      let (v1, env1) = eval_e e1 env in
      let (v2, env2) = eval_e e2 env1 in
      (match (v1, v2) with
        | (IntValue n1, IntValue n2) -> (BoolValue (n1 <> n2), env2)
        | (BoolValue b1, BoolValue b2) -> (BoolValue (b1 <> b2), env2)
        | _ -> failwith "Runtime type error: incompatible operand types for inequality check")
      | FunDef (name, exprs) ->
        let body = match exprs with
          | [] -> failwith "Empty function body"
          | [single_expr] -> single_expr
          | _ -> SeqList exprs
        in
        let env' = { env with funcs = StringMap.add name ([], body) env.funcs } in
        (VoidValue, env')
    | FunCall (name) ->
      let (params, body) =
        try StringMap.find name env.funcs
        with Not_found -> failwith ("Function not defined: " ^ name) in
      if List.length params <> 0 then
        failwith "Function call requires arguments";
      let call_env = { vars = env.vars; funcs = env.funcs } in
      try 
        let (value, new_env) = eval_e body call_env in
        (value, new_env)
      with ReturnException v -> 
        (v, env)
  in
  let env = empty_env () in
  let (res, _) = eval_e expr env in
  res

let _ =
  let lexbuf = Lexing.from_channel stdin in
  let expr = Parser.expr_root Scanner.tokenize lexbuf in
  let result = eval expr in
  let result_str = match result with
    | BoolValue(b) -> string_of_bool b
    | IntValue(i) -> string_of_int i
    | VoidValue -> "()"
  in
  print_endline result_str
