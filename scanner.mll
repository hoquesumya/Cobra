(* Ocamllex scanner for MicroC *)

{
  open Microcparse
  let indent_stack = Stack.create ()
  let current_indent = ref 0
}

let digit = ['0'-'9']
let letter = ['a'-'z' 'A'-'Z']
let space = [' ' '\t']

rule token = parse
 space+ as s { 
  let new_indent = String.length s in
  if new_indent > !current_indent then (
    Stack.push !current_indent indent_stack;
    current_indent := new_indent;
    INDENT
  ) else if new_indent < !current_indent then (
    current_indent := Stack.pop indent_stack;
    DEDENT
  );
  token lexbuf
}
| "/*"     { comment lexbuf }           (* Comments *)
| '('      { LPAREN }
| ')'      { RPAREN }
| '{'      { LBRACE }
| '}'      { RBRACE }
| ';'      { SEMI }
| ':'      { COLON }
(* COMMA *)
| ','      { COMMA }
| '+'      { PLUS }
| '-'      { MINUS }
| '='      { ASSIGN }
| "=="     { EQ }
| "!="     { NEQ }
| '<'      { LT }
| "&&"     { AND }
| "||"     { OR }
| "if"     { IF }
| "else"   { ELSE }
| "while"  { WHILE }
(* RETURN *)
| "return" { RETURN }
| "int"    { INT }
| "bool"   { BOOL }
| "true"   { BLIT(true)  }
| "false"  { BLIT(false) }
| digit+ as lem  { LITERAL(int_of_string lem) }
| letter (digit | letter | '_')* as lem { ID(lem) }
| eof { EOF }
| _ as char { raise (Failure("illegal character " ^ Char.escaped char)) }

and comment = parse
  "*/" { token lexbuf }
| _    { comment lexbuf }
