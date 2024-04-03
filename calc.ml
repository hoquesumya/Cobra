(* open Ast

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
    (* | Var x -> (StringMap.find x env, env) *)
    | Var x -> (StringMap.find x env.vars, env)
    (* | Asn (x, e) ->
      let (v, new_env) = eval_e e env in
      (v, StringMap.add x v new_env) *)
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
    | FunDef (name, params, body) ->
      let param_names = List.map (function 
                                  | Var(name) -> name 
                                  | _ -> failwith "Function parameters must be variable names") params in
      let new_funcs = StringMap.add name (param_names, body) env.funcs in
      (VoidValue, {env with funcs = new_funcs})
    
    (* | FunCall (name, args) ->
        let (params, body) = try StringMap.find name env.funcs
                             with Not_found -> failwith ("Function not defined: " ^ name) in
        let args_vals = List.map (fun arg -> fst (eval_e arg env)) args in
        if List.length params <> List.length args_vals then
          failwith "Incorrect number of arguments provided";
        let local_vars = List.fold_left2 (fun acc_env param arg_val ->
                          StringMap.add param arg_val acc_env) StringMap.empty params args_vals in
        let call_env = { vars = local_vars; funcs = env.funcs } in
        eval_e body call_env *)

        | FunCall (name, args) ->
          let (params, body) =
            try StringMap.find name env.funcs
            with Not_found -> failwith ("Function not defined: " ^ name) in
          (* Evaluate arguments in the current environment *)
          let args_vals = List.map (fun arg -> fst (eval_e arg env)) args in
          (* Prepare a new variables map for the function's execution environment *)
          let new_vars = 
            List.fold_left2 (fun acc_vars param arg_val ->
              StringMap.add param arg_val acc_vars)
              StringMap.empty params args_vals in
          (* Create a new environment for the function call *)
          let call_env = { vars = new_vars; funcs = env.funcs } in
          try 
            let (value, _) = eval_e body call_env in
            (value, env)  (* Return the result of the function call along with the original environment *)
          with ReturnException v -> 
            (v, env)  (* Handle returned value *)

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
  print_endline result_str *)


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
    | FunDef (name, params, body) ->
      let param_names = List.map (function 
                                  | Var(name) -> name 
                                  | _ -> failwith "Function parameters must be variable names") params in
      let new_funcs = StringMap.add name (param_names, body) env.funcs in
      (VoidValue, {env with funcs = new_funcs})
    | FunCall (name, args) ->
      let (params, body) =
        try StringMap.find name env.funcs
        with Not_found -> failwith ("Function not defined: " ^ name) in
      let args_vals = List.map (fun arg -> fst (eval_e arg env)) args in
      if List.length params <> List.length args_vals then
        failwith "Incorrect number of arguments provided";
      let local_vars = List.fold_left2 (fun acc_env param arg_val ->
                        StringMap.add param arg_val acc_env) StringMap.empty params args_vals in
      let call_env = { vars = local_vars; funcs = env.funcs } in
      let (value, new_env) = eval_e body call_env in
        (value, new_env)  (* Return the result of the function call along with the updated environment *)


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
