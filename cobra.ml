let () =
    let lexbuf = Lexing.from_channel stdin in
    let program = Parser.program_rule Scanner.token lexbuf in
    let sprogram = Semant.check_program program in
    print_endline (Print.string_of_program sprogram)


