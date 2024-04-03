{ open Parser }

rule tokenize = parse
  [' ' '\t' '\r' '\n'] { tokenize lexbuf }
| '(' { LPAREN }
| ')' { RPAREN }
| '{' { LBRACE }
| '}' { RBRACE }
| '+' { PLUS }
| '-' { MINUS }
| '*' { TIMES }
| '/' { DIVIDE }
| '=' { ASN }
| ';' { SEQ }
| ',' { COMMA }
| "true" { TRUE(true) }
| "false" { FALSE(false) }
| "and" { AND }
| "or" { OR }
| "def" { DEF }
| "return" { RETURN }
| ['0'-'9']+ as lit { LITERAL(int_of_string lit) }
| ['a'-'z' 'A'-'Z']+ as id { IDENTIFIER(id) }
| eof { EOF }
