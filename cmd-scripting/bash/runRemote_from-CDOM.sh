#!/bin/sh

function usage {
  echo ""
  echo "Usage: $0 \"[commands]\""
  echo ""
  echo "Example: $0 \"sudo svcadm restart xyz\""
  echo ""
  exit 1
}

if [ $# -lt 2 ]; then
  usage
fi

COMMANDS=$1

declare -a IPS=(

	)

for i in "${IPS[@]}"
do
	echo "$IP"
	ssh root@"$IP" "$COMMANDS"
	echo ""
done