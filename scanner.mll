{
  open Parser

  let line_count = ref 1
  let last_indent = ref 0
  let in_function = ref false

  let rec count_indentation s =
    let rec count_spaces i =
      if i < String.length s && s.[i] = ' ' then
        count_spaces (i + 1)
      else
        i
    in
    let rec count_tabs i =
      if i < String.length s && s.[i] = '\t' then
        count_tabs (i + 1)
      else
        i
    in
    let i = count_spaces 0 in
    let j = count_tabs i in
    if j = String.length s then
      j
    else
      failwith ("Inconsistent indentation at line " ^ string_of_int !line_count)
}

rule tokenize = parse
  [' '] { tokenize lexbuf }
| '\t' { failwith ("IndentationError: Found TAB character at line " ^ string_of_int !line_count ^ "; use spaces instead") }
| '(' { LPAREN }
| ')' { RPAREN }
| '+' { PLUS }
| '-' { MINUS }
| '*' { TIMES }
| '/' { DIVIDE }
| '=' { ASN }
| '\n' { line_count := !line_count + 1; in_function := false; SEQ }
| ':' { COLON }
| "true" { TRUE(true) }
| "false" { FALSE(false) }
| "and" { AND }
| "or" { OR }
| "not" { NOT }
| "==" { EQ }
| "!=" { NEQ }
| "def" { in_function := true; DEF }
| "return" { RETURN }
| ['0'-'9']+ as lit { LITERAL(int_of_string lit) }
| ['a'-'z' 'A'-'Z']+ as id { IDENTIFIER(id) }
| eof { EOF }
| _ { failwith ("Unexpected character '" ^ String.make 1 (Lexing.lexeme_char lexbuf 0) ^ "' at line " ^ string_of_int !line_count) }

