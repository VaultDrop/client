qtkeychain\build.bat
del CMakeCache.txt
cmake -DCMAKE_INSTALL_PREFIX=C:\dev\Qt\5.10.0\mingw53_32 -G "MinGW Makefiles" .
C:\dev\Qt\5.10.0\mingw53_32
mingw32-make install
copy ..\zlib-1.2.11\libzlib.dll bin



If this folder is foo\client, create foo\client-build and in there make two files:

client-build\build.bat

del CMakeCache.txt
cmake "-DZLIB_ROOT=C:\Program Files (x86)\zlib" -DNO_SHIBBOLETH=1 -G "MinGW Makefiles" ../client
mingw32-make


client-build\run.bat