#!/bin/bash

# fix profile chdir ssh error
mkdir /export/home/martel.meyers
(
echo "export PATH=/usr/bin:/usr/sbin"
echo "if [ -f /usr/bin/less ]; then"
echo '    export PAGER="/usr/bin/less -ins"'
echo "elif [ -f /usr/bin/more ]; then"
echo '    export PAGER="/usr/bin/more -s"'
echo "fi"
echo "case ${SHELL} in"
echo "*bash)"
echo '    typeset +x PS1="\u@\h:\w\\$ "'
echo "    ;;"
echo "esac"
) > /export/home/martel.meyers/.profile
echo 'typeset +x PS1="\u@\h:\w\\$ "' > /export/home/martel.meyers/.bashrc
groupadd martel.meyers
chown --recursive martel.meyers:martel.meyers /export/home/martel.meyers
usermod -d /export/home/martel.meyers -G staff,adm,cgiadmin,martel.meyers martel.meyers
echo "martel.meyers ALL=(ALL) NOPASSWD: ALL" >> /etc/sudoers.d/cgiadmin
