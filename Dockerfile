FROM ubuntu:22.04

ENV DEBIAN_FRONTEND=noninteractive

RUN apt-get update && apt-get install -y curl gnupg software-properties-common

# Add LLVM repository
RUN curl -fsSL https://apt.llvm.org/llvm-snapshot.gpg.key | gpg --dearmor -o /usr/share/keyrings/llvm-archive-keyring.gpg
RUN echo "deb [signed-by=/usr/share/keyrings/llvm-archive-keyring.gpg] https://apt.llvm.org/jammy/ llvm-toolchain-jammy-14 main" | tee /etc/apt/sources.list.d/llvm.list

RUN apt-get update

# Install dependencies and utilities
RUN apt-get install -y \
    git \
    build-essential \
    llvm-14 \
    llvm-14-dev \
    clang-14 \
    m4 \
    libgmp-dev \
    pkg-config \
    opam \
    cmake

# Initialize OPAM and install OCaml
RUN opam init -y --compiler=4.12.0 --disable-sandboxing
RUN opam install -y ocamlbuild ocamlfind

ENV OPAMYES=1
ENV PATH="/root/.opam/4.12.0/bin:$PATH"

RUN opam install -y llvm.14.0.6

WORKDIR /app

## TO RUN
## ocamlbuild -pkgs llvm cobra.native
## ./cobra.native -l example.mc > example.out
## lli-14 example.out
