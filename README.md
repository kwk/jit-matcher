# Installation Guide

Tested OS: Ubuntu 14.04 amd64

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

## Download LLVM and Clang

    cd ~
    mkdir -p Development
    cd Development
    git clone http://llvm.org/git/llvm.git
    cd llvm
    git svn init https://llvm.org/svn/llvm-project/llvm/trunk --username=anonymous
    git config svn-remote.svn.fetch :refs/remotes/origin/master
    git svn rebase -l  # -l avoids fetching ahead of the git mirror.
    cd tools
    git clone http://llvm.org/git/clang.git
    cd clang
    git svn init https://llvm.org/svn/llvm-project/cfe/trunk --username=anonymous
    git config svn-remote.svn.fetch :refs/remotes/origin/master
    git svn rebase -l  # -l avoids fetching ahead of the git mirror.
    
# Configuring and building LLVM and Clang

    cd ~/Development
    mkdir llvm-build
    cd llvm-build
    cmake ../llvm -DBUILD_CLANG_EXAMPLES=ON -DLIBCLANG_BUILD_STATIC=ON -DLLVM_BUILD_EXAMPLES -DLLVM_BUILD_TESTS=ON -DCMAKE_INSTALL_PREFIX=~/Development/llvm-install
    make -j10
    make test
    make install
    
# Build the program

    cd jit-matcher
    rm -rf build
    mkdir build
    cd build
    cmake .. -DCMAKE_CXX_FLAGS=-std=c++11
    LD_LIBRARY_PATH=~/Development/llvm-install/lib make


