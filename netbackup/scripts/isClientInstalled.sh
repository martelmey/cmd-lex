#!/bin/bash
# Check PS & PRD LDOMs
./runRemote.sh solaris-domain "ls /usr/openv | grep netbackup" db
./runRemote.sh solaris-domain "ls /usr/openv | grep netbackup" app
# Check CDC
./runRemote.sh solaris-domain "ls /usr/openv | grep netbackup" db
./runRemote.sh solaris-domain "ls /usr/openv | grep netbackup" app
./runRemote.sh solaris-zone "ls /usr/openv | grep netbackup" cdc

31fIMT9PyKi~kVrI|u"BDh/&
