#!/bin/bash

ORIG_PATH="$PATH"
MXE_PATH="$1"
export PATH="$MXE_PATH/usr/bin/:${ORIG_PATH}"

CC=x86_64-w64-mingw32-gcc AR=x86_64-w64-mingw32-ar CFLAGS="-DSTATICLIB -I$MXE_PATH/usr/x86_64-w64-mingw32.static/include" LDFLAGS=-L$MXE_PATH/usr/x86_64-w64-mingw32/lib make clean libminiupnpc.a
mkdir -p $MXE_PATH/usr/x86_64-w64-mingw32.static/include/miniupnpc/
cp *.h $MXE_PATH/usr/x86_64-w64-mingw32.static/include/miniupnpc/
cp libminiupnpc.a $MXE_PATH/usr/x86_64-w64-mingw32.static/lib/


#CC=i686-w64-mingw32-gcc AR=i686-w64-mingw32-ar CFLAGS="-DSTATICLIB -I$MXE_PATH/usr/i686-w64-mingw32.static/include" LDFLAGS=-L$MXE_PATH/usr/i686-w64-mingw32/lib make clean libminiupnpc.a
#mkdir -p $MXE_PATH/usr/i686-w64-mingw32.static/include/miniupnpc/
#cp *.h $MXE_PATH/usr/i686-w64-mingw32.static/include/miniupnpc/
#cp libminiupnpc.a $MXE_PATH/usr/i686-w64-mingw32.static/lib/
