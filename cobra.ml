let () =
  let lexbuf = Lexing.from_channel stdin in
  let program = Parser.program_rule Scanner.token lexbuf in
  print_endline (Print.string_of_program program)