open Ast

let _ =
  let lexbuf = Lexing.from_channel stdin in
  let expr = Parser.program Scanner.tokenize lexbuf in
  let result = eval expr in
  let result_str = match result with
    | BoolValue(b) -> string_of_bool b
    | IntValue(i) -> string_of_int i
    | VoidValue -> "()"
  in
  print_endline result_str
