#!/bin/bash

#if [[ -e '../bitcurrency' || -e "../../bitcurrency" ]]; then
#  echo "Move this script to a directory outside of and far away from the bitcurrency code base, then run it."
#  exit -1
#fi

MXE_PATH=`pwd`/mxe
CUR_DIR=`pwd`

sudo apt-get install -y qt5-default qt5-qmake qtbase5-dev-tools qttools5-dev-tools \
    build-essential git libboost-dev libboost-system-dev \
    libboost-all-dev libssl-dev libdb++-dev libminiupnpc-dev libqrencode-dev



# Get BC from github if we don't already have it
if [ ! -d "$CUR_DIR/bitcurrency" ]; then
  echo "Getting bitcurrency code from github..."
  git clone https://github.com/bitcurrency/bitcurrency
fi

# Get MXE from github if we don't already have it
if [ ! -d "$MXE_PATH" ]; then
  git clone https://github.com/mxe/mxe "$MXE_PATH"
  pushd "$MXE_PATH"
  # build QT 5 and boost .. this may take a couple hours
  nice make MXE_TARGETS='x86_64-w64-mingw32.static i686-w64-mingw32.static' boost qtbase libsodium -j 16
  popd
fi

echo "============================================================"
echo "   ** This process will take a few hours to complete **"
echo "   **   so go watch a movie, and come back later.    **"
echo "============================================================"

# remove dependency build dirs
rm -rf db-4.8.30*
rm -rf miniupnpc-1.9*
rm -rf openssl-1.0.2n*

# copy the dependency files
cp bitcurrency/depends/* ./

# unpack em
tar xfvz db-4.8.30.tar.gz
tar xfvz miniupnpc-1.9.tar.gz
tar xvfz openssl-1.0.2n.tar.gz

# build openssl
pushd openssl-1.0.2n
cp ../bitcurrency/scripts/build_openssl.sh ./build
chmod a+x ./build
./build "$MXE_PATH"
popd

# build db
pushd db-4.8.30
mkdir -p build_mxe
cd build_mxe
cp ../../bitcurrency/scripts/build_db.sh ./build
chmod a+x ./build
./build "$MXE_PATH"
popd

# build miniupnp
pushd miniupnpc-1.9
cp ../bitcurrency/scripts/build_pnp.sh ./build
chmod a+x ./build
./build "$MXE_PATH"
popd

# Build the client
pushd bitcurrency
cp scripts/build_bitcurrency.sh ./build_bc
chmod a+x build_bitcurrency.sh
./build_bc "$MXE_PATH"
popd

echo "-----------------------------------------------"
echo Done!
echo "-----------------------------------------------"
