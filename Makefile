all:
	ocamllex src/scanner.mll
	ocamlyacc src/cobraparse.mly

	ocamlc -c src/ast.ml                  
	ocamlc -c src/cobraparse.mli           
	ocamlc -c src/cobraparse.ml            
	ocamlc -c src/scanner.ml              
	ocamlc -c src/test.ml                 
	ocamlc -o test src/ast.cmo src/cobraparse.cmo src/scanner.cmo src/test.cmo 

	./test < test/hello_world.🐍 > test/hello_world.out