#!/bin/bash

#if [[ -e '../bitcurrency' || -e "../../bitcurrency" ]]; then
#  echo "Move this script to a directory outside of and far away from the bitcurrency code base, then run it."
#  exit -1
#fi

function usage() {

  echo "Usage:   $0 mxe_path arch"
  echo "Where:   mxe_path is the path to the MXE installation."
  echo "  And:   arch is 32 or 64 for the number of bits."
  exit -1

}

MXE_PATH=`pwd`/mxe
CUR_DIR=`pwd`
ARCH="$2"
BC_DIR="$CUR_DIR/bitcurrency"

if [ "$MXE_PATH" == "" ]; then
  usage
fi

if [ "$ARCH" != "32" ] && [ "$ARCH" != "64" ]; then
  usage
fi

sudo apt-get install -y qt5-default qt5-qmake qtbase5-dev-tools qttools5-dev-tools \
    build-essential git libboost-dev libboost-system-dev \
    libboost-all-dev libssl-dev libdb++-dev libminiupnpc-dev libqrencode-dev \
    autoconf automake autopoint bison flex gperf intltool libtool-bin \
    ruby scons unzip p7zip-full libgdk-pixbuf2.0-dev

# Get BC from github if we don't already have it
if [ ! -d "$CUR_DIR/bitcurrency" ]; then
  echo "Getting bitcurrency code from github..."
  git clone https://github.com/bitcurrency/bitcurrency
fi

# Get MXE from github if we don't already have it
if [ ! -d "$MXE_PATH" ]; then
  git clone https://github.com/mxe/mxe "$MXE_PATH"

  # copy mxe dependent files from the bc git
  if [ -d "$BC_DIR/depends/mxe/*" ]; then
    cp -R "$BC_DIR/depends/mxe/*" "$MXE_PATH/"
  fi

  pushd "$MXE_PATH"
  nice make MXE_PLUGIN_DIRS="plugins/examples/openssl1.0" MXE_TARGETS='x86_64-w64-mingw32.static i686-w64-mingw32.static' boost qttools libsodium -j 16
  popd

fi

echo "============================================================"
echo "   ** This process will take a few hours to complete **"
echo "   **   so go watch a movie, and come back later.    **"
echo "============================================================"

# remove dependency build dirs
rm -rf db-4.8.30*
rm -rf miniupnpc-1.9*
rm -rf openssl-1.0.0t*

# copy the dependency files
cp bitcurrency/depends/* ./

# unpack em
tar xfvz db-4.8.30.tar.gz
tar xfvz miniupnpc-1.9.tar.gz
tar xfvz openssl1.0.0t.tar.gz

#for arch in ( '64', '32' )
#do

  echo '==============================================================================='
  echo '>> Building ${arch}bit'
  echo '==============================================================================='

  # build db
  pushd db-4.8.30
  mkdir -p build_mxe
  cd build_mxe
  cp ../../bitcurrency/scripts/build_db.sh ./build
  chmod a+x ./build
  ./build "$MXE_PATH" "$ARCH"
  popd

  # build miniupnp
  pushd miniupnpc-1.9
  cp ../bitcurrency/scripts/build_pnp.sh ./build
  chmod a+x ./build
  ./build "$MXE_PATH" "$ARCH"
  popd

  # build miniupnp
  pushd openssl-1.0.0
  cp ../bitcurrency/scripts/build_openssl.sh ./build
  chmod a+x ./build
  ./build "$MXE_PATH" "$ARCH"
  popd

  # Build the client
  pushd bitcurrency
  cp scripts/build_bitcurrency.sh ./build_bc
  chmod a+x build_bc
  ./build_bc "$MXE_PATH" "$ARCH"
  popd

done

echo "-----------------------------------------------"
echo Done!
echo "-----------------------------------------------"
