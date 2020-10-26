#!/bin/bash

chown --recursive root:root /var/empty
chmod -R -rwx /var/empty
chmod -R g-rwx /var/empty
systemctl restart sshd