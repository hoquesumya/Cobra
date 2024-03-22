

type typ= Int | Bool | Float | String | Null | Dynamic |Tuple | List | None
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
| Binop of expr * binop * expr
| Memory_manage of memory * expr
| Import of expr


type MemoryMap = 
| New | Delete | Dref | Address | Retain
type binop=
| Eq | Neq | Lt | Gt | Plus | Minus| Times | Divde |Exp | Lteq| Rteq| Or | And | Mod
type elif_block = elif of expr * stmt
type memory = New | Delete | Free | Alloc | Dref
type stmt = 
Expr of expr * expr
| Elif of elif_block list
| Assign of expr list * expr
| Function of bind * bind list * stmt
| Block of stmt list
| Class of string * bind list * stmt 
| Virtual_Class of string * stmt
| Virtual_fun of bind * bind list
| For of bind * expr *stmt 
| Range of bind * expr * stmt
| If of expr * stmt * stmt
| IfElif of expr * stmt * stmt * stmt
|Break
| Continue
|Return of expr
| Import of expr
| Public of stmt
| Private of stmt
| Memory_REF of 




type program ={
  body: stmt list (*list type *)
}