

type typ= Int | Bool | Float | String | Null | Dynamic |Tuple | List | None

type memory = New | Delete | Dref | Address | Retain

type memory_ref = Makemanual | Release
(** for x:int *)
type bind = Bind of string *typ
type dot_ops = string list
type all_dref = Id of string  | Dot of dot_ops 
type binop=
| Eq | Neq | Lt | Gt | Plus | Minus| Times | Divde |Exp | Lteq| Rteq| Or | And | Mod


type all_memory_manage= All_Dref of all_dref | Expr' of expr | All_new_ops of all_new_ops
and assign_type= Vari of bind | Expr1 of expr
and all_new_ops = Type of typ | Arr_cons of typ * expr | Arr_Var of typ * string | Var of string | Arr_Var_var of string * expr | Arr_Var_Const of string * string
and 
 expr=
| Literal of int
| Float_literal of float
| Blit of bool
| Stirng_literal of string
| Variable of bind
| Assign of  assign_type * expr
| Array_assign of typ * string * string * expr
| Custom_types of string * typ list
| Dot_ops of dot_ops list
| Func_call of string * expr list
| Class_Method of string * string * expr list
| Binop of expr * binop * expr
| Memory_manage of memory * all_memory_manage
| Array of expr list


type stmt = 
Expr of expr
(*| Elif of elif_block list*)
| Block of stmt list
| Virtual_Class of string * stmt
| Virtual_fun of bind * bind list
| If of expr * stmt list * stmt
| IfElif of expr * stmt list * elif_block list * stmt list
| Return of expr
| Public of stmt
| Private of stmt
| Memory_REF of memory_ref * string
| Memory_manage1 of  memory * string
| While of expr * while_stmt
and 
elif_block = Elif' of expr * stmt list
and while_stmt=
Expr_while  of expr
| While_Block of while_stmt list
| While_Memory_REF of memory_ref * string
| While_Memory_manage1 of  memory * string
| While_stmt of stmt
| Break
| Continue
| While_if of expr * while_stmt *  while_stmt
| While_ifElif of expr * while_stmt *while_elif_block list * while_stmt

and while_elif_block = While_elif of expr * while_stmt


type func_def_dynamic = {
  fname: string;
  formals: bind list;
  body: stmt list;
}
type  func_def_typ={
  rtype: typ;
  fname: string;
  formals: bind list;
  body: stmt list;
}
type all_func= Func_dynamic of func_def_dynamic | Func_def_typ of func_def_typ
type program = all_func list


