#!/bin/bash

# save existing ruleset...
ls -lash /etc/sysconfig/iptables*
cp -pv   /etc/sysconfig/iptables{,.$(date "+%F_%T")}

# add NetBackup ports...
iptables -N NBU-IN
iptables -A NBU-IN -p tcp -m multiport -s 192.168.160.232,192.168.160.233 --dports 1556,13724 -j ACCEPT
iptables -I INPUT -j NBU-IN

# save the tables...
ls -lash /etc/sysconfig/iptables*
service iptables save