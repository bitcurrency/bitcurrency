MXE_PATH="$1"
ORIG_PATH="$PATH"

export PATH="$MXE_PATH/usr/bin/:${ORIG_PATH}"

./config --prefix="$MXE_PATH/usr/x86_64-w64-mingw32.static/"
make clean
CC=x86_64-w64-mingw32-gcc AR=x86_64-w64-mingw32-ar CFLAGS="-DSTATICLIB -I$MXE_PATH/usr/x86_64-w64-mingw32.static/include" \
	LDFLAGS=-L$MXE_PATH/usr/x86_64-w64-mingw32/lib make 
mkdir -p $MXE_PATH/usr/x86_64-w64-mingw32.static/{include/openssl-1.0.2n,lib/openssl-1.0.2n}
cp *.h $MXE_PATH/usr/x86_64-w64-mingw32.static/include/openssl-1.0.2n/
cp *.a *.pc $MXE_PATH/usr/x86_64-w64-mingw32.static/lib/openssl-1.0.2n/

#./config --prefix="$MXE_PATH/usr/i686-w64-mingw32.static/"
#make clean

#CC=i686-w64-mingw32-gcc AR=i686-w64-mingw32-ar CFLAGS="-DSTATICLIB -I$MXE_PATH/usr/i686-w64-mingw32.static/include" \
#	LDFLAGS=-L$MXE_PATH/usr/i686-w64-mingw32/lib/ make && make install
#mkdir -p $MXE_PATH/usr/i686-w64-mingw32.static/{include/openssl-1.0.2n,lib/openssl-1.0.2n}
#cp *.h $MXE_PATH/usr/i686-w64-mingw32.static/include/openssl-1.0.2n/
#cp *.a *.pc $MXE_PATH/usr/i686-w64-mingw32.static/lib

