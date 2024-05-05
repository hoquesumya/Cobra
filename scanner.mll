{ open Parser 

let typ = ref false


}

rule token = parse
  | [' ' '\n' '\t' ]* { token lexbuf }

  | "def" { DEF }
  | "endef" { ENDEF }
  | "class"  {CLASS}
  | "endcls" {ENDCLS}

  | "if" { IF }
  | "else" {ELSE }
  | "endif" {ENDIF }

  | "while" { WHILE }
  | "next" { NEXT }

  | "return" { RETURN }
  | "int" { typ := true; INT }
  | "bool" {typ := true; BOOL }
  | "true" { BLIT(true) }
  | "false" { BLIT(false) }
  | "*" { 
          print_endline (string_of_bool !typ);
          if !typ then (
            typ :=false;
            POINTER
          )
          else 
          (
            DEREF
          )
        }

  | ['0'-'9']+ as l { LITERAL(int_of_string l) }
  | ['a'-'z' 'A'-'Z']['a'-'z' 'A'-'Z' '0'-'9' '_']* as id { ID(id) }
  | '.' {DOT}
  | '+' { PLUS }
  | '-' { MINUS }
  | '=' {  typ :=false; ASSIGN }
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
  | "::" {COLON_D}
  | '&' {ADDRESS_OF}
  | "release" {RELEASE}
  | "break" {BREAK}
  | "continue" {CONTINUE}
  | "makeManual" {MAKEMAN}
  | ';' {SEMI}
  |"retain" {RETAIN}


  | eof {EOF }
  | _ as c { 
      let char_info = "Illegal character: " ^ Char.escaped c in
      print_endline char_info;
      raise (Failure char_info) 
  }