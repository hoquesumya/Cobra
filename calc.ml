open Ast

module StringMap = Map.Make(String)
type environment = value StringMap.t

let rec eval expr =
  let rec eval_e expr env : value * environment =
    match expr with
    | Lit n -> (IntValue n, env)
    | BoolLit b -> (BoolValue b, env)
    | Var x -> (StringMap.find x env, env)
    | Asn (x, e) ->
      let (v, new_env) = eval_e e env in
      (v, StringMap.add x v new_env)
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
  in
  let (res, _) = eval_e expr StringMap.empty in
  res


let _ =
  let lexbuf = Lexing.from_channel stdin in
  let expr = Parser.expr_root Scanner.tokenize lexbuf in
  let result = eval expr in
  let result_str = match result with
    | BoolValue(b) -> string_of_bool b
    | IntValue(i) -> string_of_int i
  in
  print_endline result_str
