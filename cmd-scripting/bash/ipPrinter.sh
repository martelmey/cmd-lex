#!/bin/bash

output="ips.txt"
ip="192.168.60."
octet="25"
command="'cat /opt/splunkforwarder/etc/system/local/outputs.conf'"

touch $output
echo "#!/bin/bash" >> $output

while [ $octet -le 59 ]
do
    echo "ssh " + $ip + $octet + $command >> $output
    ((i=i+1))
done