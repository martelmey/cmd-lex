#/bin/bash

cat /etc/passwd | grep martel.meyers > /dev/null

if [ $? -eq 0 ]; then
	echo "User exists. Quitting"
else
	which adduser > /dev/null
	if [ $? -gt 0 ]; then
	    useradd -d /export/home/$USER -G adm martel.meyers
	else
	    adduser -m $USER
	    chage -d 0 $USER
	fi
	passwd $USER
	cat /etc/passwd | grep $USER
fi