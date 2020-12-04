#!/bin/bash

dispatch=/var/opt/splunk/var/run/splunk/dispatch
splunkdir=/var/opt/splunk
find $dispatch -maxdepth 1 -mmin +120 2>/dev/null | while read job; do if [ ! -e "$job/save" ] ; then rm -rfv $job ; fi ; done
find $dispatch -type d -empty -name alive.token -mmin +120 2>/dev/null | xargs -i rm -Rf {}
find $splunkdir/var/run/splunk/ -type f -name "session-*" -mmin +120 2>/dev/null | xargs -i rm -Rf {}