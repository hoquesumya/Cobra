test : parser.cmo scanner.cmo print.cmo test.cmo
	ocamlc -w A -o test $^

%.cmo : %.ml
	ocamlc -w A -c $<

%.cmi : %.mli
	ocamlc -w A -c $<

scanner.ml : scanner.mll
	ocamllex $^

parser.ml parser.mli : parser.mly
	ocamlyacc $^

test.cmo : scanner.cmo parser.cmi ast.cmi print.cmo
test.cmx : scanner.cmx parser.cmx ast.cmi print.cmx
parser.cmo : ast.cmi parser.cmi
parser.cmx : ast.cmi parser.cmi
scanner.cmo : parser.cmi
scanner.cmx : parser.cmx
print.cmo : ast.cmi
print.cmx : ast.cmi

format:
	find . -name '*.ml' -or -name '*.mli' | xargs ocamlformat -i

.PHONY : clean
clean :
	rm -rf *.cmi *.cmo parser.ml parser.mli scanner.ml test.out test
