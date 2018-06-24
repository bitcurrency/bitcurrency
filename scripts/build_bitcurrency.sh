#!/bin/bash

MXE_PATH="$1"
ORIG_PATH="$PATH"

chmod a+x src/leveldb/build_detect_platform

if [ "$2" == "64" ]; then

  export PATH=$MXE_PATH/usr/bin:$MXE_PATH/usr/x86_64-w64-mingw32.static/qt5/bin/:$MXE_PATH/usr/x86_64-w64-mingw32.static/bin/:$ORIG_PATH
  OPENSSL_INCLUDE_PATH="$MXE_PATH/usr/x86_64-w64-mingw32.static/include"
  OPENSSL_LIB_PATH="$MXE_PATH/usr/x86_64-w64-mingw32.static/lib/"
  export CXXFLAGS="-L$OPENSSL_LIB_PATH -I$OPENSSL_INCLUDE_PATH"
  $MXE_PATH/usr/x86_64-w64-mingw32.static/qt5/bin/qmake USE_UPNP=1

else

  export PATH=$MXE_PATH/usr/bin:$MXE_PATH/usr/i686-w64-mingw32.static/qt5/bin/:$MXE_PATH/usr/i686-w64-mingw32.static/bin/:$ORIG_PATH
  OPENSSL_INCLUDE_PATH="$MXE_PATH/usr/i686-w64-mingw32.static/include"
  OPENSSL_LIB_PATH="$MXE_PATH/usr/i686-w64-mingw32.static/lib/"
  export CXXFLAGS="-L$OPENSSL_LIB_PATH -I$OPENSSL_INCLUDE_PATH"
  $MXE_PATH/usr/i686-w64-mingw32.static/qt5/bin/qmake USE_UPNP=1

fi

pushd src/leveldb
make clean
popd
make
