
ocamlc -c ast.ml                     # Compile the AST definition
ocamlyacc parser.mly                 # Generate parser.ml and parser.mli
ocamlc -c parser.mli                 # Compile the parser interface
ocamllex scanner.mll                   # Generate lexer.ml
ocamlc -c scanner.ml                   # Compile the lexer
ocamlc -c parser.ml                  # Compile the parser
ocamlc -c cobra.ml  
ocamlc -o my_compiler ast.cmo scanner.cmo parser.cmo cobra.cmo
