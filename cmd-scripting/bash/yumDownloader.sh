#!/bin/bash

###+++--- CDC Jump 1

###==
####===
#----- YUMDOWNLOADER
####===
###==

YUMDOWNLOADER="/root/yumdownloader"

mkdir /root/yumdownloader

yumdownloader --destdir /root/yumdownloader/ --resolve libvirt
yumdownloader --destdir /root/yumdownloader/ --resolve virt-install
yumdownloader --destdir /root/yumdownloader/ --resolve libguestfs
yumdownloader --destdir /root/yumdownloader/ --resolve libvirt-daemon
yumdownloader --destdir /root/yumdownloader/ --resolve libvirt-daemon-driver-interface
yumdownloader --destdir /root/yumdownloader/ --resolve libvirt-daemon-driver-network
yumdownloader --destdir /root/yumdownloader/ --resolve libvirt-daemon-driver-nodedev
yumdownloader --destdir /root/yumdownloader/ --resolve libvirt-daemon-driver-nwfilter
yumdownloader --destdir /root/yumdownloader/ --resolve libvirt-daemon-driver-qemu
yumdownloader --destdir /root/yumdownloader/ --resolve libvirt-daemon-driver-secret
yumdownloader --destdir /root/yumdownloader/ --resolve libvirt-daemon-driver-storage
yumdownloader --destdir /root/yumdownloader/ --resolve libvirt-daemon-driver-storage-core
yumdownloader --destdir /root/yumdownloader/ --resolve libvirt-daemon-driver-storage-disk
yumdownloader --destdir /root/yumdownloader/ --resolve libvirt-daemon-driver-storage-gluster
yumdownloader --destdir /root/yumdownloader/ --resolve libvirt-daemon-driver-storage-iscsi
yumdownloader --destdir /root/yumdownloader/ --resolve libvirt-daemon-driver-storage-logical
yumdownloader --destdir /root/yumdownloader/ --resolve libvirt-daemon-driver-storage-mpath
yumdownloader --destdir /root/yumdownloader/ --resolve libvirt-daemon-driver-storage-rbd
yumdownloader --destdir /root/yumdownloader/ --resolve libvirt-daemon-driver-storage-scsi
yumdownloader --destdir /root/yumdownloader/ --resolve libvirt-daemon-kvm                   
yumdownloader --destdir /root/yumdownloader/ --resolve qemu-common
yumdownloader --destdir /root/yumdownloader/ --resolve qemu-img
yumdownloader --destdir /root/yumdownloader/ --resolve qemu-kvm
yumdownloader --destdir /root/yumdownloader/ --resolve qemu-system-x86
yumdownloader --destdir /root/yumdownloader/ --resolve qemu-system-x86-core

cd /root
tar -zcvf yumdownloader.tar.gz yumdownloader
mv yumdownloader.tar.gz /export/pkgs/kvm
rm -rf yumdownloader/

scp /export/pkgs/kvm/yumdownloader.tar.gz martel.meyers@192.168.160.10:/home/martel.meyers

###==
####===
#----- YUMINSTALL
####===
###==

YUMINSTALL="/root/yuminstall"
YUMINSTALLROOT="/root/yuminstall-installroot"

mkdir /root/yuminstall
mkdir /root/yuminstall-installroot

yum install --downloadonly --installroot=/root/yuminstall-installroot --downloaddir=/root/yuminstall libvirt
yum install --downloadonly --installroot=/root/yuminstall-installroot --downloaddir=/root/yuminstall virt-install
yum install --downloadonly --installroot=/root/yuminstall-installroot --downloaddir=/root/yuminstall libguestfs
yum install --downloadonly --installroot=/root/yuminstall-installroot --downloaddir=/root/yuminstall libvirt-daemon
yum install --downloadonly --installroot=/root/yuminstall-installroot --downloaddir=/root/yuminstall libvirt-daemon-driver-interface
yum install --downloadonly --installroot=/root/yuminstall-installroot --downloaddir=/root/yuminstall libvirt-daemon-driver-network
yum install --downloadonly --installroot=/root/yuminstall-installroot --downloaddir=/root/yuminstall libvirt-daemon-driver-nodedev
yum install --downloadonly --installroot=/root/yuminstall-installroot --downloaddir=/root/yuminstall libvirt-daemon-driver-nwfilter
yum install --downloadonly --installroot=/root/yuminstall-installroot --downloaddir=/root/yuminstall libvirt-daemon-driver-qemu
yum install --downloadonly --installroot=/root/yuminstall-installroot --downloaddir=/root/yuminstall libvirt-daemon-driver-secret
yum install --downloadonly --installroot=/root/yuminstall-installroot --downloaddir=/root/yuminstall libvirt-daemon-driver-storage
yum install --downloadonly --installroot=/root/yuminstall-installroot --downloaddir=/root/yuminstall libvirt-daemon-driver-storage-core
yum install --downloadonly --installroot=/root/yuminstall-installroot --downloaddir=/root/yuminstall libvirt-daemon-driver-storage-disk
yum install --downloadonly --installroot=/root/yuminstall-installroot --downloaddir=/root/yuminstall libvirt-daemon-driver-storage-gluster
yum install --downloadonly --installroot=/root/yuminstall-installroot --downloaddir=/root/yuminstall libvirt-daemon-driver-storage-iscsi
yum install --downloadonly --installroot=/root/yuminstall-installroot --downloaddir=/root/yuminstall libvirt-daemon-driver-storage-logical
yum install --downloadonly --installroot=/root/yuminstall-installroot --downloaddir=/root/yuminstall libvirt-daemon-driver-storage-mpath
yum install --downloadonly --installroot=/root/yuminstall-installroot --downloaddir=/root/yuminstall libvirt-daemon-driver-storage-rbd
yum install --downloadonly --installroot=/root/yuminstall-installroot --downloaddir=/root/yuminstall libvirt-daemon-driver-storage-scsi
yum install --downloadonly --installroot=/root/yuminstall-installroot --downloaddir=/root/yuminstall libvirt-daemon-kvm                   
yum install --downloadonly --installroot=/root/yuminstall-installroot --downloaddir=/root/yuminstall qemu-common
yum install --downloadonly --installroot=/root/yuminstall-installroot --downloaddir=/root/yuminstall qemu-img
yum install --downloadonly --installroot=/root/yuminstall-installroot --downloaddir=/root/yuminstall qemu-kvm
yum install --downloadonly --installroot=/root/yuminstall-installroot --downloaddir=/root/yuminstall qemu-system-x86
yum install --downloadonly --installroot=/root/yuminstall-installroot --downloaddir=/root/yuminstall qemu-system-x86-core

tar -zcvf yuminstall.tar.gz yuminstall
mv yuminstall.tar.gz /export/pkgs/kvm
rm -rf yuminstall/

scp /export/pkgs/kvm/yuminstall.tar.gz martel.meyers@192.168.160.10:/home/martel.meyers

###==
####===
#----- YUMREPO
####===
###==

YUMREPO="/root/yumrepo"
YUMREPOCACHE="/root/yumrepo/yumcache"

mkdir -p /root/yumrepo/yumcache

reposync \
--arch=x86_64 \
--repoid=ol7_x86_64_latest \
--cachedir=/root/yumrepo/yumcache \
--download_path=/root/yumrepo \
--gpgcheck \
--plugins \
--downloadcomps \
--download-metadata \
--newest-only 

tar -zcvf yumrepo.tar.gz yumrepo
mv yumrepo.tar.gz /home/martel.meyers
rm -rf yumrepo/

###+++--- CDC cutlprdhwu04

cd /root
scp martel.meyers@192.168.160.10:/home/martel.meyers/yumdownloader.tar.gz .
scp martel.meyers@192.168.160.10:/home/martel.meyers/yuminstall.tar.gz .
tar -zxvf yumdownloader.tar.gz
tar -zxvf yuminstall.tar.gz

cd yuminstall
yum install *.rpm

cd yumdownloader
yum install *.rpm