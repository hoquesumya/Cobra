{ open Parser }

rule token = parse
  | [' ' '\n' '\t' ]* { token lexbuf }

  | "def" { DEF }
  | "endef" { ENDEF }

  | "if" { IF }
  | "else" {ELSE }
  | "endif" {ENDIF }

  | "while" { WHILE }
  | "next" { NEXT }

  | "return" { RETURN }
  | "int" { INT }
  | "bool" { BOOL }
  | "int*" { INTPTR }
  | "bool*" { BOOLPTR }
  | "true" { BLIT(true) }
  | "false" { BLIT(false) }

  | ['0'-'9']+ as l { LITERAL(int_of_string l) }
  | ['a'-'z' 'A'-'Z']['a'-'z' 'A'-'Z' '0'-'9' '_']* as id { ID(id) }

  | '*' { STAR }
  | '/' { DIV }
  | '+' { PLUS }
  | '-' { MINUS }
  | '=' { ASSIGN }
  | "==" { EQ }
  | "!=" { NEQ }
  | '<' { LT }
  | '>' { GT }
  | "<=" { LTE }
  | ">=" { GTE }
  | ':' { COLON }
  | '(' { LPAREN }
  | ')' { RPAREN }
  | ',' { COMMA }
  | '&' { AMP }

  | eof {EOF }
  | _ as c { 
      let char_info = "Illegal character: " ^ Char.escaped c in
      print_endline char_info;
      raise (Failure char_info) 
  }