#!/bin/bash

VM=kutlprdsplunk01
SNAPSHOT-NAME=1589390713
VHD-NAME=kutlprdsplunk01
INT=150
ROOT-DEVICE=/dev/vda
PARTITION-NUMBER=2
ROOT-PARTITION=/dev/vda2
ROOT-FS=/dev/mapper/ol-root
ROOT-MOUNTPOINT=/

# ON ROOT
virsh destroy $VM
virsh snapshot-delete --domain $VM --snapshotname $SNAPSHOT-NAME
qemu-img resize $VHD-NAME +$INTG
virsh start $VM

# ON VM
yum install cloud-utils-growpart -y
lsblk
growpart $ROOT-DEVICE $PARTITION-NUMBER
lsblk
pvresize $ROOT-PARTITION
pvs
vgs
df -hT | grep mapper
lvextend -l +100%FREE $ROOT-FS
df -ht | grep mapper
zfs_growfs $ROOT-MOUNTPOINT
df -hT | grep mapper