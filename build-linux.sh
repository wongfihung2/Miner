#!/bin/bash

# Default for cortex-a53 optimized builds
clear

export feature="native"
export CC=gcc
export CXX=g++
export CFS="-O3 -Ofast -march=$feature -mcpu=$feature -mtune=$feature -maes -mavx2 -fvisibility=hidden -funroll-loops -fomit-frame-pointer -fassociative-math -funsafe-math-optimizations -funsafe-loop-optimizations -faggressive-loop-optimizations -ftree-parallelize-loops=4 -ftree-loop-optimize -floop-nest-optimize -foptimize-sibling-calls -foptimize-strlen -fexpensive-optimizations -freorder-functions -finline-functions -Wno-implicit-function-declaration -Wno-incompatible-pointer-types -Wno-int-conversion -Wno-error -std=gnu99"
export CXS="-O3 -Ofast -march=$feature -mcpu=$feature -mtune=$feature -maes -mavx2 -fvisibility=hidden -funroll-loops -fomit-frame-pointer -fassociative-math -funsafe-math-optimizations -funsafe-loop-optimizations -faggressive-loop-optimizations -ftree-parallelize-loops=4 -ftree-loop-optimize -floop-nest-optimize -foptimize-sibling-calls -foptimize-strlen -fexpensive-optimizations -freorder-functions -finline-functions -Wno-implicit-function-declaration -Wno-incompatible-pointer-types -Wno-int-conversion -Wno-error -std=gnu++17"
export CFLAGS="$CFS"
export CXXFLAGS="$CXS"
export LIBS="-lcurl -lcrypto -lssl"
export LDFLAGS="-Wl,-s"

make clean
make distclean
rm configure config.status
autoreconf -i
./configure --with-crypto --with-curl --disable-shared CC="$CC" CXX="$CXX" CFLAGS="$CFLAGS" CXXFLAGS="$CFLAGS" LDFLAGS="$CXXFLAGS $LDFLAGS" LIBS="$LIBS"
nano Makefile
make -j4
