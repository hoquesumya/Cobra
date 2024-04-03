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
| ':' { COLON }
| "true" { TRUE(true) }
| "false" { FALSE(false) }
| "and" { AND }
| "or" { OR }
| "not" { NOT }
| "==" { EQ }
| "!=" { NEQ }
| "def" { DEF }
| "return" { RETURN }
| ['0'-'9']+ as lit { LITERAL(int_of_string lit) }
| ['a'-'z' 'A'-'Z']+ as id { IDENTIFIER(id) }
| eof { EOF }
