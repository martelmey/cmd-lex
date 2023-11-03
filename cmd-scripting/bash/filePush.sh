#!/bin/sh
#
# file_push.sh
#

function usage {
  echo ""
  echo "Usage: $0 [solaris-domain|solaris-zone|linux|all] <filename> [env]"
  echo ""
  exit 1
}

if [ $# -lt 2 ]; then
  usage
fi

TYPE=$1
FILE=$2
TARGETENV=$3

if [ "$TYPE" != "linux" -a "$TYPE" != "solaris-domain" -a "$TYPE" != "solaris-zone" -a "$TYPE" != "all" ]; then
  usage
fi

if [ "$TYPE" == "solaris-domain" -o "$TYPE" == "solaris-zone" ]; then
  FILEDIR=solaris
else
  FILEDIR=linux
fi

for i in `grep -v ^# targets`
do
  IP=`echo $i | cut -d ":" -f 1`
  OS=`echo $i | cut -d ":" -f 2`
  SERVERENV=`echo $i | cut -d ":" -f 3`

  # Optionally push to just linux or solaris
  if [ "$OS" != "$TYPE" -a "$TYPE" != "all" ]; then continue; fi
  # or just one environment
  if [ "x$TARGETENV" != "x" -a "$TARGETENV" != "$SERVERENV" ]; then continue; fi

  echo "$IP"
  scp files/$FILEDIR/$FILE $IP:/tmp/
  echo ""
done
