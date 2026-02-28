#!/bin/bash

clear
apt install libuv1-dev libhwloc-dev
tar -xvf v6.25.0.tar.gz
mkdir -pv xmrig-6.25.0/build
cd xmrig-6.25.0/build
cmake -DBUILD_STATIC=ON ..
make -j4
strip -sv xmrig
mv xmrig ../..
