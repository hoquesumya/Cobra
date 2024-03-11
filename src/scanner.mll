(*Ocamllex scanner for Cobra *)
{
    open Cobraparse
    exception Eof

}

let digit = ['0'-'9']
let float = digit+('.')digit*
let letter = ['a'-'z' 'A'-'Z']
let string = ('"'[^'"''\\']*('\\'_[^'"''\\']*)*'"')
let array = ('[' ((digit+',')*|(float ',')*|(string ',')*) ']' ) (*homogenous array*)
(*TODO-> tuple regex*)

rule coralToken = parse
    [' ' '\r'] { token lexbuf } 
| '#'         { comment lexbuf }
| '\n'      { EOL}
| '\t'      { TAB }
| ':'       { Colon }
| 'if'      { IF }
| 'else'    { ELSE }
| 'elif'    { ELIF }
| "not"     { NOT }
| 'and'     { AND }
| 'or'      { OR }
| '+'       { PLUS }
| '-'       { MINUS }
| "/"      { DIVIDE }
| '*'       { TIMES }
| "=="      { EQ }
| "%"       { MODULUS }
| "!="      { NEQ }
| "<"       { LT }
| '>'       { RT } 
| '>='      { LTEQ }
| "<="      {RTEQ}
| "**"      { EXP }
| "+="      { PLUSEQ }
| "-="      { MINUSEQ }
| "*="      { TIMESEQ }
| "/="      { DIVIDEEQ}
| '{'       { LBRACE }
| '}'       { RBRACE }
| '['       { LBRACK }
| ']'       { RBRACK }
| '('       { LPAREN }
| ')'       { RPAREN }
| "="       {ASSIGN }
| ','       { COMMA }
| "&&"      { AND }
| "break"   { BREAK }
| "continue" { CONTINUE }
| "class"   { CLASS }
| "public"  {PUBLIC}
| "private" {PRIVATE}
| "static"  {STATIC}
| "int"     { INT }
| "bool"    { BOOL }
| "true"    { BLIT(true) }
| "false"   { BLIT(false) }
| "str"     { STRING }
| "&"       {REF}
| "type"    {TYPE}
| "for"     { FOR }
| "while"   { WHILE }
| "def"     { DEF }
|'return'   { RETURN }
| 'None'    { NULL }
| 'NaN'     { Nan }
| 'import'  { IMPORT }
| 'new'     { NEW }
| 'delete'  { DELETE }
| 'free'    { free }
| "try"     { TRY }
| 'catch'   { CATCH }
| '->'      { RVAL }
| "except"  { EXCEPT }
| array as arr {ARRAY (arr)}
| digit+ as lem {Literal (int_of_string lem)}
| float as fl {Float_Lit (float_of_string fl)}
| letter (letter | digit | '_')* as id  {Variable (id)} (*capturing the value of ID*)
| _ as char { raise (Failure("illegal character " ^ Char.escaped char)) }
|  eof  { raise Eof }
| string as str {String_Lit (str)}

and comment = parse
 '\n' {token lexbuf}
| _ {comment lexbuf}
