setup:
	cd ~ && \
	mkdir -p Development && \
	cd Development && \
	git clone http://llvm.org/git/llvm.git && \
	cd llvm && \
	git svn init https://llvm.org/svn/llvm-project/llvm/trunk --username=anonymous && \
	git config svn-remote.svn.fetch :refs/remotes/origin/master && \
	git svn rebase -l && \
	cd tools && \
	git clone http://llvm.org/git/clang.git && \
	cd clang && \
	git svn init https://llvm.org/svn/llvm-project/cfe/trunk --username=anonymous && \
	git config svn-remote.svn.fetch :refs/remotes/origin/master && \
	git svn rebase -l && \
	cd ~/Development && \
	mkdir llvm-build && \
	cd llvm-build && \
	cmake ../llvm -DBUILD_CLANG_EXAMPLES=ON -DLIBCLANG_BUILD_STATIC=ON -DLLVM_BUILD_EXAMPLES -DLLVM_BUILD_TESTS=ON -DCMAKE_INSTALL_PREFIX=~/Development/llvm-install && \
	make -j10 && \
	make test && \
	make install

all:
	rm -rf build && \
	mkdir build && \
	cd build && \
	cmake .. -DLLVM_ROOT=~/Development/llvm-install -DCMAKE_CXX_FLAGS=-std=c++11 && \
	LD_LIBRARY_PATH=~/Development/llvm-install/lib make
