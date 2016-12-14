#!/bin/bash

mkdir build
cd build

../configure \
  CXX=g++ \
  CC=gcc \
  CFLAGS="-I$PREFIX/include" \
  CXXFLAGS=" -m64 -I$PREFIX/include" \
  --with-blas-lib="-Wl,-rpath,$PREFIX/lib -L$PREFIX/lib -lopenblas" \
  --with-asl-lib="-Wl,-rpath,$PREFIX/lib -L$PREFIX/lib -lasl" \
  --with-mumps-lib="-Wl,-rpath,$PREFIX/lib -L$PREFIX/lib -ldmumps -lmumps_common -lpord -lmpiseq -lgfortran" \
  --prefix=$PREFIX

make
make test
make install
