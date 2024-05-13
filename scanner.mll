(* Ocamllex scanner for Cobra *)

{ open Cobraparse }

let digit = ['0'-'9']
let letter = ['a'-'z' 'A'-'Z']

rule token = parse
  [' ' '\t' '\r'] { token lexbuf } (* Whitespace *)
| ['\n']+     { NEWLINE }
| '('      { LPAREN }
| ')'      { RPAREN }
| "def"    { DEF }
| "endef"  { ENDEF }
| "->"     { ARROW }
| ':'      { COLON }
| ','      { COMMA }
| '+'      { PLUS }
| '-'      { MINUS }
| '/'      { DIV }
| '*'      { MULT }
| '='      { ASSIGN }
| "=="     { EQ }
| "!="     { NEQ }
| '<'      { LT }
| "<="      { LTE }
| '>'      { GT }
| ">="      { GTE }
| "and"     { AND }
| "or"     { OR }
| "if"     { IF }
| "else"   { ELSE }
| "while"  { WHILE }
| "return" { RETURN }
| "int"    { INT }
| "bool"   { BOOL }
| "int*" { INTPTR }
| "bool*" { BOOLPTR }
| "True"   { BLIT(true)  }
| "False"  { BLIT(false) }
| digit+ as lem  { LITERAL(int_of_string lem) }
| letter (digit | letter | '_')* as lem { ID(lem) }
| eof { EOF }
| _ as char { raise (Failure("illegal character " ^ Char.escaped char)) }
