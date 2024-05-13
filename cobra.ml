type action = Ast | Sast | LLVM_IR

let () =
  let action = ref Ast in
  let set_action a () = action := a in
  let speclist = [
    ("-a", Arg.Unit (set_action Ast), "Print AST");
    ("-s", Arg.Unit (set_action Sast), "Print SAST");
    ("-l", Arg.Unit (set_action LLVM_IR), "Print generated LLVM IR");
  ] in
  let usage_msg = "usage: ./cobra.native [-a|-s|-l] [file]" in
  let channel = ref stdin in
  Arg.parse speclist (fun filename -> channel := open_in filename) usage_msg;

  let lexbuf = Lexing.from_channel !channel in

  let ast = Cobraparse.program Scanner.token lexbuf in
  match !action with
    Ast -> print_string (Print.string_of_program ast)
  | _ -> let sast = Semant.check ast in
    match !action with
      Ast     -> ()
    | Sast    -> print_string (Print.string_of_sprogram sast)
    | LLVM_IR -> print_string (Llvm.string_of_llmodule (Irgen.translate sast))
