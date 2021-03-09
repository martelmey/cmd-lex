#/bin/bash

read -p "Type username to add: " USER

which adduser > /dev/null
if [ $? -gt 0 ]; then
    mkdir -p /home/$USER
    useradd -d /home/$USER $USER
    groupadd $USER
    usermod -G $USER,wheel $USER
    chown --recursive $USER:$USER /home/$USER
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
