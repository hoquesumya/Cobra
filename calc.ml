open Ast

module StringMap = Map.Make(String)

let rec eval expr =
  let rec eval_e expr env =
    match expr with
    | Lit n -> (n, env)
    | Var x -> StringMap.find x env, env
    | Asn (x, e) ->
      let (v, new_env) = eval_e e env in
      (v, StringMap.add x v new_env)
    | Seq (e1, e2) ->
      let (_, env1) = eval_e e1 env in
      eval_e e2 env1
    | Binop (e1, op, e2) ->
      let (v1, env1) = eval_e e1 env in
      let (v2, env2) = eval_e e2 env1 in
      let result = match op with
        | Add -> v1 + v2
        | Sub -> v1 - v2
        | Mul -> v1 * v2
        | Div -> v1 / v2 in
      (result, env2)
  in
  let (res, _) = eval_e expr StringMap.empty in
    res

let _ =
  let lexbuf = Lexing.from_channel stdin in
  let expr = Parser.expr Scanner.tokenize lexbuf in
  let result = eval expr in
  print_endline (string_of_int result)
