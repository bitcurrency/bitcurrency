#!/bin/bash

ORIG_PATH="$PATH"
MXE_PATH="$1"

export PATH="$MXE_PATH/usr/bin/:${ORIG_PATH}";CC=x86_64-w64-mingw32-gcc CXX=x86_64-w64-mingw32-g++ ../dist/configure --disable-replication --enable-mingw --enable-cxx --host x86_64 --prefix=$MXE_PATH/usr/x86_64-w64-mingw32.static
make clean && make -j 8
make install

#export PATH="$MXE_PATH/usr/bin/:${ORIG_PATH}";CC=i686-w64-mingw32-gcc CXX=i686-w64-mingw32-g++ ../dist/configure --disable-replication --enable-mingw --enable-cxx --host i686 --prefix=$MXE_PATH/usr/i686-w64-mingw32.static
#make clean && make -j 8
#make install
