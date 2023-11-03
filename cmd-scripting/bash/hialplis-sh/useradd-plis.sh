#!/bin/bash
#
# userAdd-local.sh
#
# Create local accounts for sys admins on all servers in any env

JUMPSERVER=$(hostname)
USERNAME=$1
TARGETENV=$2
HERE=$(pwd)
SUDOERNAME="${USERNAME//./}"
SHADOWLINE="perl -pe 's|($USERNAME):(\$.*?:)|\1:\$5\$rounds=10000\$\$X/zj2kjkqmmsbOdrjhn3u/molujLP0tUwzqkzmTvtB1:|' /etc/shadow > /etc/shadow.new"
SUDOLINE='echo "$USERNAME ALL=(ALL) NOPASSWD: ALL" > /etc/sudoers.d/$SUDOERNAME'

usage() {
  echo ""
  echo "Usage: $0 [username] [env]"
  echo ""
  echo "Example: $0 test.user dev"
  echo ""
  exit 1
}

if [ $# -lt 2 ]; then
  usage
fi

for i in `grep -v ^# targets`
do

  IP=`echo $i | cut -d ":" -f 1`
  OS=`echo $i | cut -d ":" -f 2`
  SERVERENV=`echo $i | cut -d ":" -f 3`

  if [[ $SERVERENV == $TARGETENV ]]; then

  	HOSTNAME=$(dig -x $IP +short | head -n1 | cut -d "." -f 1)
		echo "($OS) $IP : $HOSTNAME"

		# create user - if non-existant
		ssh "$IP" "sudo grep -q $USERNAME /etc/passwd"
		if [[ $? -eq 0 ]]; then
			echo "$USERNAME already exists."
		else
			echo "$USERNAME doesn't exist, creating.."
			ssh "$IP" "sudo useradd -d /export/home/$USERNAME -m -s /usr/bin/bash $USERNAME >/dev/null"

			# add to groups - if user is new
			ssh "$IP" "sudo grep -q cgistaff /etc/group"
			if [[ $? -eq 0 ]]; then
				echo "adding $USERNAME to group: cgistaff"
		  		ssh "$IP" "sudo usermod -aG cgistaff $USERNAME'"
			fi
			ssh "$IP" "sudo grep -q cgiadmin /etc/group"
			if [[ $? -eq 0 ]]; then
				echo "adding $USERNAME to group: cgiadmin"
		  		ssh "$IP" "sudo usermod -aG cgiadmin $USERNAME'"
			fi
			ssh "$IP" "sudo grep -q wheel /etc/group"
			if [[ $? -eq 0 ]]; then
				echo "adding $USERNAME to group: wheel"
		  		ssh "$IP" "sudo usermod -aG wheel $USERNAME'"
			fi
			sleep 2

		fi
		sleep 2

		# set password
#		rm -f $HERE/slashTmp-chShadow.sh
#		echo "#!/bin/bash" > $HERE/slashTmp-chShadow.sh
#		echo $SHADOWLINE >> $HERE/slashTmp-chShadow.sh
#		chmod u+x $HERE/slashTmp-chShadow.sh
#		scp $HERE/slashTmp-chShadow.sh "$IP":/tmp/chShadow.sh
#		ssh "$IP" "sudo /tmp/chShadow.sh"
#		sleep 2

		# expire password
		ssh "$IP" "sudo passwd -d $USERNAME"
		if [[ $OS == "solaris-zone" || $OS == "solaris-domain" ]]; then
			ssh "$IP" "sudo passwd -d $USERNAME"
			ssh "$IP" "sudo passwd -f $USERNAME"
		else
			ssh "$IP" "sudo passwd -e $USERNAME"
		fi
		sleep 2

		# add to /etc/sudoers.d, if non-existant
		ssh "$IP" "sudo ls /etc/sudoers.d | grep $USERNAME"
		if [[ $? -gt 0 ]]; then
			rm -f $HERE/slashTmp-addSudoer.sh
			echo "#!/bin/bash" > $HERE/slashTmp-addSudoer.sh
			echo "touch /etc/sudoers.d/$SUDOERNAME" >> $HERE/slashTmp-addSudoer.sh
			echo $SUDOLINE >> $HERE/slashTmp-addSudoer.sh
			chmod u+x $HERE/slashTmp-addSudoer.sh
			scp $HERE/slashTmp-addSudoer.sh "$IP":/tmp/addSudoer.sh
			ssh "$IP" "sudo /tmp/addSudoer.sh"
			sleep 2
		fi

		# send keys

		# final checks
		ssh "$IP" "sudo cat /etc/passwd | grep $USERNAME \
		&& sudo groups $USERNAME \
		&& sudo cat /etc/sudoers.d/$SUDOERNAME"
		echo ""
  fi
done
