MXE_PATH="$1"
ORIG_PATH="$PATH"

export PATH="$MXE_PATH/usr/bin/:$ORIG_PATH"

if [ "$2" == "64" ]; then

	./config --prefix="$MXE_PATH/usr/x86_64-w64-mingw32.static/"
	make clean
	CC=x86_64-w64-mingw32-gcc AR=x86_64-w64-mingw32-ar CFLAGS="-DSTATICLIB -I$MXE_PATH/usr/x86_64-w64-mingw32.static/include" \
		LDFLAGS=-L$MXE_PATH/usr/x86_64-w64-mingw32/lib make && make install

else

	./config --prefix="$MXE_PATH/usr/i686-w64-mingw32.static/"
	make clean
	CC=i686-w64-mingw32-gcc AR=i686-w64-mingw32-ar CFLAGS="-DSTATICLIB -I$MXE_PATH/usr/i686-w64-mingw32.static/include" \
		LDFLAGS=-L$MXE_PATH/usr/i686-w64-mingw32/lib make && make install

fi
