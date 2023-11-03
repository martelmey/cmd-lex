#!/bin/bash
#
# todo
# 1. show /etc/resolv.conf nameservers

for i in `grep -v ^# hostnames`
do
	nslookup "$i"
done