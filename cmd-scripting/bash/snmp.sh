#!/usr/bin/bash

read -p "Choose: Solaris or Linux   [s/l]: "  OS

if [[ "$OS" == "s" ]]; then
    #[] assert DISABLE=no
    #[] assert rocommunity public
    #[] assert rwcommunity private
    #[] trap2sink <host> <communitystring> <trapport> example: trap2sink 10.18.141.22 public 162
    #[] svcadm restart svc:/application/management/net-snmp:default
elif [[ "$OS" == "l" ]]; then
    CRON_DIR="/var/spool/cron"
    SPLUNK_TAR="splunk-8.0.4-767223ac207f-Linux-x86_64.tgz"
    HOME_ROOT="/home"
    PROFILE=".bash_profile"
    ADMGROUP="wheel"
fi