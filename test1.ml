open Ast
open Print

let _ =
  let lexbuf = Lexing.from_channel stdin in
  let program = Cobraparse.program Scanner.token lexbuf in
  print_endline (Print.string_of_program program)
