#!/bin/bash

fdisk /dev/vdb
mkfs.ext4 /dev/vdb1
mkdir /disk2/
mount /dev/vdb1 /disk2/
cp /etc/fstab /etc/fstab.old
echo '/dev/vdb1    /disk2    ext4     defaults    0 0'>>/etc/fstab
mkdir /disk2/db_np-temp && mkdir /disk2/db_np-temp/db && mkdir /disk2/db_np-temp/colddb && mkdir /disk2/db_np-temp/thaweddb
mkdir /disk2/os_evt_np-temp && mkdir /disk2/os_evt_np-temp/db && mkdir /disk2/os_evt_np-temp/colddb && mkdir /disk2/os_evt_np-temp/thaweddb
mkdir /disk2/wls_np-temp && mkdir /disk2/wls_np-temp/db && mkdir /disk2/wls_np-temp/colddb && mkdir /disk2/wls_np-temp/thaweddb
chown --recursive splunk:splunk db_np-temp/
chown --recursive splunk:splunk os_evt_np-temp/
chown --recursive splunk:splunk wls_np-temp/
# Delete *-temp indxs via web ui
su - splunk -c 'splunk stop'
rm -rf /export/os_evt_np-temp
rm -rf /export/db_np-temp
rm -rf /export/wls_np-temp
su - splunk -c 'splunk start'
# Create *-temp indxs via web