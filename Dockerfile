FROM debian:bullseye-slim

RUN apt-get update && apt-get install -y opam libzstd-dev llvm-16-dev zlib1g-dev

RUN opam init -a --disable-sandboxing && \
    opam switch create 4.12.0

RUN opam install llvm ocamlbuild ocamlfind -y

ENV OPAMYES=1
ENV PATH="/root/.opam/4.12.0/bin:$PATH"

WORKDIR /app

RUN mkdir test
