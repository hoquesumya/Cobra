test : parser.cmo scanner.cmo test.cmo
	ocamlc -w A -o test $^

%.cmo : %.ml
	ocamlc -w A -c $<

%.cmi : %.mli
	ocamlc -w A -c $<

scanner.ml : scanner.mll
	ocamllex $^

parser.ml parser.mli : parser.mly
	ocamlyacc $^

# Depedencies from ocamldep
test.cmo : scanner.cmo parser.cmi ast.cmi
test.cmx : scanner.cmx parser.cmx ast.cmi
parser.cmo : ast.cmi parser.cmi
parser.cmx : ast.cmi parser.cmi
scanner.cmo : parser.cmi
scanner.cmx : parser.cmx


##############################


.PHONY : clean
clean :
	rm -rf *.cmi *.cmo parser.ml parser.mli scanner.ml test.out test
