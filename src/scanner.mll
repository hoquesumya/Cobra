{ open Parser }

rule tokenize = parse
  [' '] { tokenize lexbuf }
| '(' { LPAREN }
| ')' { RPAREN }
| '+' { PLUS }
| '-' { MINUS }
| '*' { TIMES }
| '/' { DIVIDE }
| '=' { ASN }
| '\n' { SEQ }
| "true" { TRUE(true) }
| "false" { FALSE(false) }
| "and" { AND }
| "or" { OR }
| "not" { NOT }
| "==" { EQ }
| "!=" { NEQ }
| ['0'-'9']+ as lit { LITERAL(int_of_string lit) }
| ['a'-'z' 'A'-'Z']+ as id { VARIABLE(id) }
| eof { EOF }
