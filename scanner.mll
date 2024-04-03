{ open Parser }

rule tokenize = parse
  [' ' '\t' '\r' '\n'] { tokenize lexbuf }
| ['0'-'9']+ as lit { LITERAL(int_of_string lit) }
| ['a'-'z' 'A'-'Z']+ as id { VARIABLE(id) }
| '(' { LPAREN }
| ')' { RPAREN }
| '+' { PLUS }
| '-' { MINUS }
| '*' { TIMES }
| '/' { DIVIDE }
| '=' { ASN }
| ';' { SEQ }
| eof { EOF }
