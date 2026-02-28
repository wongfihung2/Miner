#!/bin/bash

# Default for cortex-a53 optimized builds
clear
# -fprofile-reproducible=[serial|parallel-runs|multithreaded]
export feature="simd+crypto+crc"
export CC=gcc
export CXX=g++
export CFS="-Ofast -march=armv8-a+$feature -mcpu=cortex-a53+$feature -mtune=cortex-a53 -fvisibility=hidden -funroll-loops -fomit-frame-pointer -fprofile -fprofile-generate=./profile -fprofile-dir=./profile -fprofile-correction -fprofile-abs-path -fprofile-reorder-functions -fassociative-math -funsafe-math-optimizations -funsafe-loop-optimizations -faggressive-loop-optimizations -floop-parallelize-all -ftree-parallelize-loops=4 -ftree-loop-optimize -floop-nest-optimize -foptimize-crc -foptimize-sibling-calls -foptimize-strlen -fexpensive-optimizations -Wno-implicit-function-declaration -Wno-incompatible-pointer-types -Wno-int-conversion -Wno-error -fopenmp"
export CFLAGS="$CFS -std=gnu23"
export CXXFLAGS="$CFS -std=gnu++23"
export LIBS="-lcurl -lcrypto -lssl"
export LDFLAGS="-static -Wl,-s"

make clean
make distclean
#rm configure config.status
#autoreconf -i
./configure --with-crypto --with-curl --disable-shared CC="$CC" CXX="$CXX" CFLAGS="$CFLAGS" CXXFLAGS="$CFLAGS" LDFLAGS="$CXXFLAGS -std=gnu23 $LDFLAGS" LIBS="$LIBS"
nano Makefile
make -j4
