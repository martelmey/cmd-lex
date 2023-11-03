#!/bin/sh

function usage {
  echo ""
  echo "Usage: $0 [solaris-domain|solaris-zone|linux|all] \"[file]\" \"[where to drop]\" [env]"
  echo ""
  echo "Example: $0 solaris-zone \"doit\" \"/tmp\" int2"
  echo ""
  exit 1
}

if [ $# -lt 2 ]; then
  usage
fi

TYPE=$1
FILE=$2
LOCATION=$3
TARGETENV=$4

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
  scp "$FILE" $IP:/"$LOCATION"
  echo ""
done
