{
  open Parser
}

let digit = ['0'-'9']
let letter = ['a'-'z' 'A'-'Z']
let identifier = letter (letter | digit | '_')*
let space = [' ' '\t']+
let newline = '\n'

rule token = parse
  | space { token lexbuf }  (* Ignore whitespace *)
  | newline { token lexbuf }  (* Ignore newlines *)
  | "def" { DEF }
  | "if" { IF }
  | "else" { ELSE }
  | "print" { PRINT }
  | '(' { LPAREN }
  | ')' { RPAREN }
  | ',' { COMMA }
  | '{' { LBRACE }
  | '}' { RBRACE }
  | digit+ as lxm { INT(int_of_string lxm) }
  | identifier as lxm { ID(lxm) }
  | eof { EOF }
  | _ { raise (Failure "Lexing error") }
