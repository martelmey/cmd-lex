#!/bin/bash
ls -l /var/lib/postfix/master.lock
fuser /var/lib/postfix/master.lock > ~/postfix-pid-number
ps -ef | grep `~/postfix-pid-number`
kill `~/postfix-pid-number`
postfix status
postfix start