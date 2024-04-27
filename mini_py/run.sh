#!/bin/bash

ocamlc -c ast.ml                     # Compile the AST definition
ocamlyacc parser.mly                 # Generate parser.ml and parser.mli
ocamlc -c parser.mli                 # Compile the parser interface
ocamllex lexer.mll                   # Generate lexer.ml
ocamlc -c lexer.ml                   # Compile the lexer
ocamlc -c parser.ml                  # Compile the parser
ocamlc -c print_ast.ml               # Compile the AST printer

ocamlc -o my_compiler ast.cmo lexer.cmo parser.cmo print_ast.cmo main.cmo
