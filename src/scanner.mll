(*Ocamllex scanner for Cobra *)
{
    open Cobraparse
    exception Eof
}
let digit = ['0'-'9']
let float = digit+'.'digit*
let letter = ['a'-'z' 'A'-'Z']
let string = ('"'[^'"''\\']*('\\'_[^'"''\\']*)*'"')

rule corbraToken = parse
    [' ' '\r'] { token lexbuf } 
| '#'         { comment lexbuf }
| '\n'      { EOL}
| '\t'      { TAB }
| ':'       { Colon }
| "if"      { IF }
| "else"   { ELSE }
| "elif"    { ELIF }
| "not"     { NOT }
| "and"     { AND }
| "or"     { OR }
| "in"      {IN}
| "range"   {RANGE}
| '.'       {DOT}
| '*'       { DREF }
| '+'       { PLUS }
| '-'       { MINUS }
| "/"      { DIVIDE }
| '*'       { TIMES }
| "=="      { EQ }
| "%"       { MODULUS }
| "!="      { NEQ }
| "<"      { LT }
| '>'       { GT } 
| ">="      { LEQ }
| "<="      { GEQ }
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
| "="       { ASN }
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
| "float"   {FLOAT}
| "tuple"   {TUPLE}
| "list"    { LIST }
| "string"     { STRING }
| "&"       {ADDRESS_OF}
| "type"    {TYPE}
| "for"     { FOR }
| "while"   { WHILE }
| "def"     { DEF }
|"return"  { RETURN }
| "None"   { NULL }
| "NaN"     { Nan }
| "import"  { IMPORT }
| "new"     { NEW }
| "delete"  { DELETE }
| "free"    { FREE }
| "try"     { TRY }
| "catch"   { CATCH }
| "->"     { ARROW }
|"makeManual" { MAKEMANUAL }
| "release"   { RELEASE }
| "virtual" {VIRTUAL}
| "except"  { EXCEPT }
| "true"    { BLIT(true) }
| "false"   { BLIT(false) }
| digit+ as lem {Literal (int_of_string lem)}
| float as fl {Float_Lit (float_of_string fl)}
| letter (letter | digit | '_')* as id  {VERIABLE (id)} (*capturing the value of ID*)
| _ as char { raise (Failure("illegal character " ^ Char.escaped char)) }
|  eof  { EOF }
| string as str {String_Lit (string_of_format str)}

and comment = parse
 '\n' {EOL}
| _ {comment lexbuf}
