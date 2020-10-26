#!/usr/bin/bash

ps -ef | grep collectdmon | grep -v status | grep -v grep

if [ $? -gt 0 ]; then
    /opt/collectd/svc/collectdsvc.sh start
fi