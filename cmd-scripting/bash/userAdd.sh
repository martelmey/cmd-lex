#/bin/bash

read -p "Type username to add: " USER

which adduser > /dev/null
if [ $? -gt 0 ]; then
    mkdir -p /export/home/$USER
    groupadd $USER
    useradd -d /export/home/$USER -G cgistaff,$USER $USER
    chown --recursive $USER:$USER /export/home/$USER
else
    adduser -m $USER
    chage -d 0 $USER
fi

passwd $USER

passwd -e user.name > /dev/null
if [ $? -gt 0 ]; then
    passwd -e $USER
else
    passwd expire $USER
fi

cat /etc/passwd | grep $USER

# 192.168.160.10
# 192.168.161.25
# 192.168.161.26