# README

The project is an experiment to combine a JIT
compiler with Clang's AST matching patterns.

It probably won't pan out, but I wanted to
give it a try.

At it's current state, the project does nothing.

# Installation guide

Tested OS: Ubuntu 14.04 amd64
May also work on Mac OSX Mavericks.

# WARNING

Do not use the apt sources from llvm.org it will simply not work.

Most of the documentation written for LLVM and Clang assume, that
you've built LLVM and Clang yourself.

That is what we're going to do as well.

# Prerquisites

Ensure that you don't have as minimal LLVM, LLDB, or Clang components installed as possible.

Run 

    dpkg -l *llvm*
    dpkg -l *clang*
    dpkg -l *lldb*

to find out what's installed.

# Installation

To download, configure, compile and install the prerequisites (LLVM and Clang) just run `make setup` in this directory.

To build the program itelf run `make`.
