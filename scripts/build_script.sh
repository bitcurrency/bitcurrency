#!/bin/bash

if [[ -e '../bitcurrency' || -e "../../bitcurrency" ]]; then
  echo "Move this script to a directory outside of and far away from the bitcurrency code base, then run it."
  exit -1
fi

sudo apt-get install -y qt5-default qt5-qmake qtbase5-dev-tools qttools5-dev-tools \
    build-essential git libboost-dev libboost-system-dev \
    libboost-filesystem-dev libboost-program-options-dev libboost-thread-dev \
    libssl-dev libdb++-dev libminiupnpc-dev libqrencode-dev

git clone https://github.com/bitcurrency/bitcurrency
git clone https://github.com/mxe/mxe
cd /mxe

# build QT 5 and boost .. this may take a couple hours
nice make MXE_TARGETS='x86_64-w64-mingw32.static i686-w64-mingw32.static' boost qtbase libsodium openssl -j 16

cd ..
wget "http://download.oracle.com/berkeley-db/db-4.8.30.tar.gz"
wget "http://miniupnp.free.fr/files/download.php?file=miniupnpc-1.9.tar.gz" -O miniupnpc-1.9.tar.gz

tar xfvz db-4.8.30.tar.gz
tar xfvz miniupnpc-1.9.tar.gz

cd db-4.8.30
mkdir build_mxe
cd build_mxe
cp ../../bitcurrency/scripts/build_db.sh ./build
chmod a+x ./build
./build

cd ../..
cd miniupnpc-1.9
cp ../bitcurrency/scripts/build_pnp.sh ./build
chmod a+x ./build
./build

cd ../bitcurrency
cd scripts
chmod a+x build_bitcurrency.sh
./build_bitcurrency.sh

Echo Done!
