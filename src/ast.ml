

type typ= Int | Bool | Float | String | Null | Dynamic |Tuple | List
(** for x:int *)
type bind = Bind of string *typ
type expr=
Listaccess of expr * expr
| Listslice expr * expr * expr
| Literal of int
| Float_literal of float
| Blit of bool
| Stirng_literal of string
| Variable of bind
| Assign of expr * expr
| Func_call of expr * expr list
| Class_Method of expr * expr * expr list
| Virtual_fun of bind * bind list
| Binop of expr * binop * expr
| Memory_manage of memory * expr

type binop=
| Eq | NEq | Lt | Gt | Plus | Minus| Times | Divde |Exp | Lteq| Rteq| Or | And
type elif_block = elif of expr * stmt
type memory = New | Delete | Free | Alloc | Dref
type stmt = 
Expr of expr 
| Elif of elif_block list
| Function of bind * bind list * stmt
| Block of stmt list
| Class of string * bind list * stmt 
| Virtual_Class of string * stmt
| For of bind * expr *stmt 
| Range of bind * expr * stmt
| If of expr * stmt * stmt
| IfElif expr * stmt * stmt * stmt
|Break
| Continue


type program ={
  body: stmt list (*list type *)
}