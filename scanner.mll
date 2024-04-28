{
  open Parser
  let token_queue = Queue.create ()
  let indent_stack = Stack.create ()
  let current_indent = ref 0
  let tab_width = 4  (* Define how many spaces a tab counts for *)

  let calculate_indentation line =
    let length = String.length line in
    let rec count idx acc =
      if idx < length then
        match line.[idx] with
        | ' ' -> count (idx + 1) (acc + 1)
        | '\t' -> count (idx + 1) (acc + 4)  (* Assuming one tab is equivalent to 4 spaces *)
        | _ -> acc
      else
        acc
    in
    count 0 0

  let update_indentation line_indent =
    if Stack.is_empty indent_stack || line_indent > Stack.top indent_stack then begin
      Stack.push line_indent indent_stack;
      print_endline "INDENT";
      current_indent := line_indent;
      Some INDENT  (* Emit INDENT token *)
    end else if line_indent < Stack.top indent_stack then begin
      while not (Stack.is_empty indent_stack) && line_indent < Stack.top indent_stack do
        ignore (Stack.pop indent_stack);
      done;
      current_indent := line_indent;
      print_endline "DEDENT";
      Some DEDENT  (* Emit DEDENT token *)
    end else None  (* No change in indentation level *)

  let rec next_token lexbuf =
    if Queue.is_empty token_queue then
      EOF  (* Finally return EOF when the queue is empty after all dedents *)
    else
      Queue.take token_queue
}

rule token = parse
  | [' ']* { token lexbuf }  (* Handle newline and proceed to count indentation *)
  | ['\t']* as whitespaces {
      let line = Lexing.lexeme lexbuf in
      let line_indent = calculate_indentation line in (
      (* let line_indent = String.length whitespaces in ( *)
        (* print_endline ("TAB: " ^ string_of_int !current_indent ^ " ind: " ^ string_of_int line_indent); *)
        match update_indentation line_indent with
        | Some INDENT -> INDENT
        | Some DEDENT -> DEDENT
        | None -> (
          (* print_endline ("TAB NO IND/DE: " ^ string_of_int !current_indent); *)
          token lexbuf
        )
      )
    }
  | ['\n']* as whitespaces {
    let line = Lexing.lexeme lexbuf in
    let line_indent = String.length whitespaces in (
    (* let line_indent = calculate_indentation line in ( *)
      print_endline ("NEWLINE LINE INDENT: " ^ string_of_int line_indent ^ " LAST " ^ string_of_int !current_indent);

      (* if line_indent < !current_indent then (
        current_indent := !current_indent - 1;
        ignore (Stack.pop indent_stack);
        print_endline ("NEW LINE DEDENT");
        DEDENT
      ) else token lexbuf *)
      token lexbuf
    )
  } 
  | eof { 
    while not (Stack.is_empty indent_stack) do
      Queue.push DEDENT token_queue;
      ignore (Stack.pop indent_stack)
    done;
    next_token lexbuf
  }  (* Handle end of file *)
  | "def" { print_endline "DEF"; DEF }
  | "if" { print_endline "IF"; IF }
  | "else" { print_endline "ELSE"; ELSE }
  | "while" { print_endline "WHILE"; WHILE }
  | "return" { print_endline "RETURN"; RETURN }
  | "int" { print_endline "INT"; INT }
  | "bool" { print_endline "BOOL"; BOOL }
  | "true" { print_endline "TRUE"; BLIT(true) }
  | "false" { print_endline "FALSE"; BLIT(false) }
  | ['0'-'9']+ as l { print_endline ("LITERAL"); LITERAL(int_of_string l) }
  | ['a'-'z' 'A'-'Z']['a'-'z' 'A'-'Z' '0'-'9' '_']* as id { print_endline ("ID"); ID(id) }
  | '+' { print_endline "PLUS"; PLUS }
  | '-' { print_endline "MINUS"; MINUS }
  | '=' { print_endline "ASSIGN"; ASSIGN }
  | "==" { print_endline "EQ"; EQ }
  | "!=" { print_endline "NEQ"; NEQ }
  | '<' { print_endline "LT"; LT }
  | '>' { print_endline "GT"; GT }
  | ':' { print_endline "COLON"; COLON }
  | '(' { print_endline "LPAREN"; LPAREN }
  | ')' { print_endline "RPAREN"; RPAREN }
  | ',' { print_endline "COMMA"; COMMA }
  | _ as c { 
      let char_info = "Illegal character: " ^ Char.escaped c in
      print_endline char_info;
      raise (Failure char_info) 
  }
