let () =
  let lexbuf = Lexing.from_channel stdin in
  try
    let parsed_program = Parser.program Lexer.token lexbuf in
    Print_ast.print_ast parsed_program
  with
  | Lexer.Error msg ->
    Printf.fprintf stderr "%s%!" msg
  | Parser.Error ->
    Printf.fprintf stderr "At offset %d: syntax error.\n%!" (Lexing.lexeme_start lexbuf)
