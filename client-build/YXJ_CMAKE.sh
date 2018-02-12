#!/bin/bash

rm CMakeCache.txt
cmake -DCMAKE_INSTALL_PREFIX=../install -D_OPENSSL_LIBDIR=/usr/local/opt/openssl/lib/ -D_OPENSSL_INCLUDEDIR=/usr/local/opt/openssl/include/ -DOPENSSL_INCLUDE_DIR=/usr/local/opt/openssl/include/ -DCMAKE_PREFIX_PATH=/usr/local/Cellar/qt/5.10.0_1/lib -DNO_SHIBBOLETH=1 ..
make
# Sign installer here???
make install
admin/osx/create_mac.sh ../install . "Developer ID Installer: Vault Drop, LLC (9968GEYSTF)"

VDVER=$(grep MIRALL_VERSION_FULL version.h | sed -e 's/#define MIRALL_VERSION_FULL //' | sed -e 's/[" ]//g')
sed -e "s/VALUT_DROP_VERSION/${VDVER}/g" '../yxj_autoupdate_versions/macos.xml.in' > '../yxj_autoupdate_versions/macos.xml'
cp ../install/VaultDrop-${VDVER}-git.pkg ../install/VaultDrop-${VDVER}-git.pkg.tbz ../yxj_autoupdate_versions/
cp ../install/VaultDrop-${VDVER}-git.pkg ../yxj_autoupdate_versions/VaultDrop-${VDVER}.pkg



