#!/bin/bash
#
# userdel-local.sh
#
# Delete local sys admin accounts from env,
# and revoke sudoer privs

USERNAME=$1
TARGETENV=$2
SUDOERNAME="${USERNAME//./}"

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

	# check for user, remove
	ssh "$IP" "sudo grep $USERNAME /etc/passwd>/dev/null"
	if [[ $? -eq 0 ]]; then
		echo "user $USERNAME found, deleting.."
		ssh "$IP" "sudo userdel -r $USERNAME"

		# check for sudoer file, remove
		ssh "$IP" "sudo ls /etc/sudoers.d | grep $SUDOERNAME>/dev/null"
		if [[ $? -eq 0 ]]; then
			ssh "$IP" "sudo rm -f /etc/sudoers.d/$SUDOERNAME"
		fi
	else
		echo "user $USERNAME not found in /etc/passwd"
	fi

	# final check
	echo "cat /etc/passwd for $USERNAME:"
	ssh "$IP" "sudo cat /etc/passwd | grep $USERNAME"
	echo "ls /etc/sudoers.d for $SUDOERNAME:"
	ssh "$IP" "sudo ls /etc/sudoers.d | grep $SUDOERNAME"
	echo "ls /export/home for $USERNAME:"
	ssh "$IP" "sudo ls /export/home | grep $USERNAME"

	echo ""
  fi
done
