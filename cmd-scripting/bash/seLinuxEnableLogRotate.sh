#!/bin/bash

yum install -y policycoreutils policycoreutils-python
semanage port -a -t http_port_t -p tcp 10087
setsebool -P httpd_can_network_connect 1
semanage permissive -a logrotate_t