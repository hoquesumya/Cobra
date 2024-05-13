FROM debian:bullseye-slim

RUN apt-get update && apt-get install -y \
    llvm-dev \
    llvm-16 \
    opam

RUN opam init -a --disable-sandboxing && \
    opam switch create 4.12.0 

ENV OPAMYES=1
ENV PATH="/root/.opam/4.12.0/bin:$PATH"

WORKDIR /app

COPY . /app

RUN make

CMD ./cobra < ./tests/full.🐍
