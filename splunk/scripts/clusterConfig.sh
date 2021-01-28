#!/bin/bash

cp /opt/splunk/etc/system/local/server.conf /opt/splunk/etc/system/local/server.conf.old
sed -i '1 a site = site1' /opt/splunk/etc/system/local/server.conf
(
	echo "[replication_port://9887]"
	echo "[clustering]"
	echo "master_uri = https://x.x.x.x:8089"
	echo "mode = slave"
	echo "pass4SymmKey = hialplissplunk"
)>>/opt/splunk/etc/system/local/server.conf