#!/bin/bash

apt update
apt install -y curl git live-build cdebootstrap
cd /media/mxana/A8A8-A710
git clone https://gitlab.com/kalilinux/build-scripts/live-build-config.git

cd live-build-config
lb config
(
	echo "firmware-misc-nonfree"
	echo "firmware-linux-nonfree"
	echo "firmware-linux"
	echo "firmware-brcm80211"
	echo "firmware-bnx2"
	echo "firmware-bnx2x"
	echo "broadcom-sta-common"
	echo "broadcom-sta-dkms"
)>>kali-config/variant-xfce/package-lists/kali.list.chroot

# dpkg-divert
# dctrl-tools
./build.sh --variant xfce \
--verbose --no-rename