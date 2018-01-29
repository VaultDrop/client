#!/bin/bash -x

sudo docker run -v "/home/yonasj/client:/home/yonasj/client" owncloud-client-win32:2.3.5 bash -x /home/yonasj/client/admin/win/docker/build.sh client/ $(id -u)

cp build-win32/VaultDrop-2.5.0.0git-setup.exe /media/sf_VaultDrop/