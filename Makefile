all:
	rm -rf build && \
	mkdir build && \
	cd build && \
	cmake .. -DCMAKE_CXX_FLAGS=-std=c++11 && \
	LD_LIBRARY_PATH=~/Development/llvm-install/lib make
