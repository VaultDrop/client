#!/bin/bash -x

sudo docker run -v "/home/yonasj/client:/home/yonasj/client" owncloud-client-win32:2.3.5 bash -x /home/yonasj/client/admin/win/docker/build.sh client/ $(id -u)

sudo cp ../../../build-win32/VaultDrop-2.*-setup.exe /media/sf_VaultDrop/client/yxj_autoupdate_versions

VDVER=$(grep MIRALL_VERSION_FULL ../../../build-win32/version.h | sed -e 's/#define MIRALL_VERSION_FULL //' | sed -e 's/[" ]//g')

sudo sed -e "s/VALUT_DROP_VERSION/${VDVER}/g" /media/sf_VaultDrop/client/yxj_autoupdate_versions/download.html.in -e 'w /media/sf_VaultDrop/client/yxj_autoupdate_versions/download.html'
sudo sed -e "s/VALUT_DROP_VERSION/${VDVER}/g" /media/sf_VaultDrop/client/yxj_autoupdate_versions/macos.xml.in -e 'w /media/sf_VaultDrop/client/yxj_autoupdate_versions/macos.xml'
sudo sed -e "s/VALUT_DROP_VERSION/${VDVER}/g" /media/sf_VaultDrop/client/yxj_autoupdate_versions/win32.xml.in -e 'w /media/sf_VaultDrop/client/yxj_autoupdate_versions/win32.xml'


