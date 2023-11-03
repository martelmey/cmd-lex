#!/bin/bash
touch clients << put in hostnames by line
# push_client_SW
for client in `cat clients`
do
 echo $client
 install_client_files ssh $client
 echo
done