(*Ocamllex scanner for Cobra *)
{
    open Parser
    let indent_stack = Stack.create ()
    let current_indent = ref 0
    
    let start_line = ref false
    let strip_quotes str =
        match String.length str with
        | 0 | 1 | 2 -> ""
        | len -> String.sub str 1 (len - 2)
}
let digit = ['0'-'9']
let float = digit+'.'digit*
let letter = ['a'-'z' 'A'-'Z']
let string = ('"'[^'"''\\']*('\\'_[^'"''\\']*)*'"')
let space = [' ' '\t']


rule corbraToken = parse
['\r'] {  corbraToken lexbuf } 
| '#'         { comment lexbuf }
| space+ as s{ 

    if !start_line then (
        let new_indent = String.length s in
            print_endline ("Current indent:  [" ^ string_of_int new_indent ^ "]");
            if new_indent > !current_indent then (
                Stack.push !current_indent indent_stack;
                current_indent := new_indent;
                INDENT
            ) else if new_indent < !current_indent then (
                current_indent := Stack.pop indent_stack;
                DEDENT
            ) else (
                (* Handle case where new_indent == !current_indent *)
                (* Return some default token or raise an error *)
                (* For now, assuming it's a syntax error *)
                SAME_INDENT
               
            )

    )
    else (
        corbraToken lexbuf 
    )

}

| '\n'+    {start_line := true; print_endline("hit new line");EOL} 
| ':'       { COLON }
| "if"      {start_line := false; IF }
| "|"       {UNION}
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
| "import"  { IMPORT }
| "new"     { NEW }
| "delete"  { DELETE }
| "->"     { ARROW }
|"makeManual" { MAKEMANUAL }
| "release"   { RELEASE }
| "retain"    {RETAIN}
|"type"       {TYPE}
| "virtual" {VIRTUAL}
| "true"    { BLIT(true) }
| "false"   { BLIT(false) }
| digit+ as lem {Literal (int_of_string lem)}
| float as fl {Float_Lit (float_of_string fl)}
| letter (letter | digit | '_')* as id  {start_line:= false; VARIABLE (id)} (*capturing the value of ID*)
| _ as char { raise (Failure("illegal character " ^ Char.escaped char)) }
|  eof  { EOF }
| string as str {String_Lit ((strip_quotes str))}

and comment = parse
 '\n' {EOL}
| _ {comment lexbuf}
