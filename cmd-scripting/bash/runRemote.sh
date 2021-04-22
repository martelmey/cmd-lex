#!/bin/sh
#
# run.sh
#
# Run commands on a set of servers.
# The set of commands should be wrapped in double quotes it contains white
#   space.

function usage {
  echo ""
  echo "Usage: $0 [solaris-domain|solaris-zone|linux|all] \"[commands]\" [env]"
  echo ""
  echo "Example: $0 solaris-zone \"sudo svcadm restart xyz\" int2"
  echo ""
  exit 1
}

if [ $# -lt 2 ]; then
  usage
fi

TYPE=$1
COMMANDS=$2
TARGETENV=$3

if [ "$TYPE" != "linux" -a "$TYPE" != "solaris-domain" -a "$TYPE" != "solaris-zone" -a "$TYPE" != "all" ]; then
  usage
fi

for i in `grep -v ^# targets`
do
  IP=`echo $i | cut -d ":" -f 1`
  OS=`echo $i | cut -d ":" -f 2`
  SERVERENV=`echo $i | cut -d ":" -f 3`

  # Optionally run on just linux or solaris
  if [ "$OS" != "$TYPE" -a "$TYPE" != "all" ]; then continue; fi
  # or just one environment
  if [ "x$TARGETENV" != "x" -a "$TARGETENV" != "$SERVERENV" ]; then continue; fi

  echo "$IP"
  ssh $IP "$COMMANDS"
  echo ""
done
