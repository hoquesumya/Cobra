module L =  Llvm

module A = Ast
open Sast

module StringMap = Map.make(String)

(** did this according to the  *)
let translate (locals,body) = 

  (**creating global context *)
  let context = L.global_context() in

  let the_module = L.create_module context "Cobra" in
 (**pointer and types *)
  let int_i = L.i32_type context in
  and bool_t     = L.i1_type     context in 

  let int_pt = L.pointer_type int_t
  and bool_pt = L.pointer_type bool_t in

  let ltype_of_typ = function
  A.Int   -> int_i
  | A.Bool  -> bool_t
  in

  (**inset func def to the the_module we nned the address *)
   (**to do define function and global variables *)

   (**to do implement local_vars *)
   (*look for lookup function *)
   let lookup n = try StringMap.find n local_vars in

   let build_expr ((_, e) : sexpr) =  match e with 
    | SLiteral i -> L.const_int int_i i
    | SBoolLit b  -> L.const_int bool_t (if b then 1 else 0) 
    | SVar s -> L.build_load (lookup s) s
    | 

in

   let rec build_stmt  = function 
      SBlock sl -> List.fold_left build_stmt
      | SExpr e ->  build_expr e
      

   in 
    build_stmt 
  in 


  the_module