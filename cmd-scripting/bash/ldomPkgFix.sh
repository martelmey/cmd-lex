#!/usr/bin/bash

#knpapp11    192.168.63.41
#knpapp12    192.168.63.42 [done]
#knpapp13    192.168.63.43 [done]

mkdir -p /export/pkgs
mount 192.168.61.132:\export/utilities-kdcprd/pkgs /export/pkgs/

cp /export/pkgs/splunk/pkg.oracle.com.key.pem /root
cp /export/pkgs/splunk/pkg.oracle.com.certificate.pem /root

pkg set-publisher -k /root/pkg.oracle.com.key.pem \
-c /root/pkg.oracle.com.certificate.pem \
--proxy http://192.168.60.250:8008 \
-G "*" -g https://pkg.oracle.com/solaris/support/ solaris