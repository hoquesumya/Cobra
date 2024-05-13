### Build the Cobra compiler

```
ocamlbuild -pkgs llvm cobra.native
```

### Run the Cobra compiler and generate llvm code
```
./cobra.native -l example.mc > example.out
```

### Run the llvm code
```
lli example.out
```

### Compiler files
-  `ast.ml`: abstract syntax tree (AST) definition
-  `scanner.mll`: scanner
-  `cobraparse.mly`: parser
-  `sast.ml`: definition of the semantically-checked AST
-  `semant.ml`: semantic checking

### Other files

- `test1.ml`: the file to test the scanner and parser
- `test2.ml`: the file to test the semantic checker
- `cobra.ml`: top-level file to test and run cobra compiler
- `example.mc`: a sample cobra source code
- `example.out`: a sample compiled code of example.mc

### Run Docker Steps

docker build -t cobra .
docker run -v $(pwd):/app -it cobra /bin/bash
ocamlbuild -pkgs llvm cobra.native
./cobra.native -l example.mc > example.out
lli-14 example.out