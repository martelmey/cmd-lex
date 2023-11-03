#!/bin/bash
echo "Configuring email..."
mv /var/tmp/sendmail.mc /var/tmp/mailertable /etc/mail/cf/cf
cd /etc/mail/cf/cf
/usr/ccs/bin/m4 ../m4/cf.m4 sendmail.mc > sendmail.cf
mv /etc/mail/sendmail.cf /etc/mail/sendmail.cf.bak
cp sendmail.cf /etc/mail/sendmail.cf
echo "smtp.cdc.health.local" >> /etc/mail/mailertable
echo "smtp.cdc.health.local" >> /etc/mail/mailertable
makemap hash /etc/mail/mailertable < /etc/mail/mailertable
svcadm restart smtp
echo "Email setup complete"