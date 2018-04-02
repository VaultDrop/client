#!/bin/bash

rm CMakeCache.txt
cmake -DCMAKE_INSTALL_PREFIX=../install -D_OPENSSL_LIBDIR=/usr/local/opt/openssl/lib/ -D_OPENSSL_INCLUDEDIR=/usr/local/opt/openssl/include/ -DOPENSSL_INCLUDE_DIR=/usr/local/opt/openssl/include/ -DCMAKE_PREFIX_PATH=/usr/local/Cellar/qt/5.10.0_1/lib -DNO_SHIBBOLETH=1 ..
make
# Sign the app before we make the installer.
../admin/osx/sign_app.sh "bin/VaultDrop.app" "Developer ID Application: Vault Drop, LLC (9968GEYSTF)"
make install
admin/osx/create_mac.sh ../install . "Developer ID Installer: Vault Drop, LLC (9968GEYSTF)"

VDVER=$(grep MIRALL_VERSION_FULL version.h | sed -e 's/#define MIRALL_VERSION_FULL //' | sed -e 's/[" ]//g')
VDVERSUF=$(grep MIRALL_VERSION_SUFFIX version.h | sed -e 's/#define MIRALL_VERSION_SUFFIX //' | sed -e 's/[" ]//g')



sed -e "s/VALUT_DROP_VERSION_SUFFIX/${VDVERSUF}/g" -e "s/VALUT_DROP_VERSION/${VDVER}/g" '../yxj_autoupdate_versions/macos.xml.in' > "../yxj_autoupdate_versions/macos${VDVERSUF}.xml"
sed -e "s/VALUT_DROP_VERSION_SUFFIX/${VDVERSUF}/g" -e "s/VALUT_DROP_VERSION/${VDVER}/g" '../yxj_autoupdate_versions/macos-sparkle.xml.in' > "../yxj_autoupdate_versions/macos-sparkle${VDVERSUF}.xml"

cp -v "../install/VaultDrop-${VDVER}${VDVERSUF}.pkg"     "../yxj_autoupdate_versions/VaultDrop-${VDVER}${VDVERSUF}.pkg"
cp -v "../install/VaultDrop-${VDVER}${VDVERSUF}.pkg.tbz" "../yxj_autoupdate_versions/VaultDrop-${VDVER}${VDVERSUF}.pkg.tbz"
cp -v "../install/VaultDrop-${VDVER}${VDVERSUF}.pkg"     "../yxj_autoupdate_versions/VaultDrop${VDVERSUF}.pkg"



