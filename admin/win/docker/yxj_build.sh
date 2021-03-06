#!/bin/bash

sudo docker run -v "/home/yonasj/client:/home/yonasj/client" owncloud-client-win32:2.4 bash -x /home/yonasj/client/admin/win/docker/build.sh client/ $(id -u)
VDVER=$(grep MIRALL_VERSION_FULL ../../../build-win32/version.h | sed -e 's/#define MIRALL_VERSION_FULL //' | sed -e 's/[" ]//g')

SIGNKEY=`cat code_sign_key`


osslsigncode -pkcs12 ../../../yxj_vaultdrop_certificate/VaultDropCodeSigningKey.pfx -h sha256 \
          -pass $SIGNKEY \
          -n "VaultDrop Client" \
          -i "http://www.VaultDrop.com" \
          -ts "http://timestamp.comodoca.com" \
          -in ../../../build-win32/VaultDrop-${VDVER}-git-setup.exe \
          -out ../../../build-win32/VaultDrop-${VDVER}-cs-setup.exe

sed -e "s/VALUT_DROP_VERSION/${VDVER}/g" '../../../yxj_autoupdate_versions/download.html.in' > '../../../yxj_autoupdate_versions/download.html'
sed -e "s/VALUT_DROP_VERSION/${VDVER}/g" '../../../yxj_autoupdate_versions/win32.xml.in' > '../../../yxj_autoupdate_versions/win32.xml'

cp -v ../../../build-win32/VaultDrop-${VDVER}-cs-setup.exe ../../../yxj_autoupdate_versions/*.xml ../../../yxj_autoupdate_versions/*.html /media/sf_VaultDrop/client/yxj_autoupdate_versions/
cp -v ../../../build-win32/VaultDrop-${VDVER}-cs-setup.exe /media/sf_VaultDrop/client/yxj_autoupdate_versions/VaultDrop-setup.exe

mkdir -p /media/sf_VaultDrop/client/yxj_autoupdate_versions/try
cp -v ../../../build-win32/bin/VaultDrop.exe ../../../build-win32/bin/*.dll /media/sf_VaultDrop/client/yxj_autoupdate_versions/try

# ../../../build-win32/src/libsync/CMakeFiles/VaultDropsync.dir/objects.a
