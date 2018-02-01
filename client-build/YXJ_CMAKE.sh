cmake -DCMAKE_INSTALL_PREFIX=../install/ -D_OPENSSL_LIBDIR=/usr/local/opt/openssl/lib/ -D_OPENSSL_INCLUDEDIR=/usr/local/opt/openssl/include/ -DOPENSSL_INCLUDE_DIR=/usr/local/opt/openssl/include/ -DCMAKE_PREFIX_PATH=/usr/local/Cellar/qt/5.10.0_1/lib -DNO_SHIBBOLETH=1 ..
make
make install
admin/osx/create_mac.sh ../install .
