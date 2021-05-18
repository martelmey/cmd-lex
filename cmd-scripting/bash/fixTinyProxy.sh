#!/bin/bash
# /etc/tinyproxy/tinyproxy.conf
# User tinyproxy
# Group tinyproxy
# PidFile "/var/run/tinyproxy/tinyproxy.pid"

systemctl stop tinyproxy
kill -9 # all tinyproxy processes
touch /etc/systemd/system/tinyproxy.service
chown -R tinyproxy:tinyproxy /etc/tinyproxy
chown -R tinyproxy:tinyproxy
chown -R tinyproxy:tinyproxy
systemctl start tinyproxy