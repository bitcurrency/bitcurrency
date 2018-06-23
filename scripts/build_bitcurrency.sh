#!/bin/bash

MXE_PATH="$1"

export PATH=$MXE_PATH/usr/bin:$MXE_PATH/usr/x86_64-w64-mingw32.static/qt5/bin/:$MXE_PATH/usr/x86_64-w64-mingw32.static/bin/:$MXE_PATH/usr/x86_64-w64-mingw32/bin:${PATH}
export CXXFLAGS="-std=c++11 -I$MXE_PATH/usr/x86_64-w64-mingw32.static/include"
export CFLAGS="-std=c++11 -I$MXE_PATH/usr/x86_64-w64-mingw32.static/include"
$MXE_PATH/usr/x86_64-w64-mingw32.static/qt5/bin/qmake
make


export PATH=$MXE_PATH/usr/bin:$MXE_PATH/usr/i686-w64-mingw32.static/qt5/bin/:$MXE_PATH/usr/i686-w64-mingw32.static/bin/:$MXE_PATH/usr/i686-w64-mingw32/bin:${PATH}
export CXXFLAGS="-std=c++11 -I$MXE_PATH/usr/i686-w64-mingw32.static/include"
export CFLAGS="-std=c++11 -I$MXE_PATH/usr/i686-w64-mingw32.static/include"
$MXE_PATH/usr/i686-w64-mingw32.static/qt5/bin/qmake
make
