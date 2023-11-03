#!/bin/bash

FILE_INPUT=$1
HOSTNAMES=hostnames
IPS=ips
UNION=union

# get hostname
grep --perl-regexp -o "\w+-\w+|-\w+/g" $FILE_INPUT > $HOSTNAMES

# get ips
grep --perl-regexp -o "\d+.\d.\d+.\d+" $FILE_INPUT > $IPS

# join
paste $HOSTNAMES $IPS > $UNION