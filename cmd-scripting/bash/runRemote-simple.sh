#!/bin/bash

COMMAND=""

for i in `grep -v ^# targets-simple`
do
  IP=`echo $i | cut -d ":" -f 1`

  echo "$IP"
  ssh $IP "$COMMAND"
  echo ""
done
