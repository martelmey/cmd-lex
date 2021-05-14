#!/bin/bash
# on master:
openssl req -x509 -node -newkey rsa:4096 -keyout /root/.ssh/id_rsa.pub -out /root/.ssh/id_rsa # or ssh-keygen
# on clients:
sudo su - root
cd ~/
chmod 700 .ssh
cd .ssh
cat /export/pkgs/NetBackup/Client/id_rsa.pub >> authorized_keys
svcadm restart svc:/network/ssh:default