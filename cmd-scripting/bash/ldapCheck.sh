#!/bin/bash
ldapsearch -x -b "uid=test.user,ou=people,dc=health,dc=local" -h ldap1.kdc.health.local
if [ $? -gt 0 ]; then
        echo $(date) "LDAPCheck failed!" >> /opt/splunkforwarder/etc/apps/base_*_*/ldapCheck.log
else
        echo $(date) "LDAPCheck successful." >> /opt/splunkforwarder/etc/apps/base_*_*/ldapCheck.log
fi
