#!/bin/bash

chown -R root:root /var/empty
chmod -R u+rwx /var/empty
chmod -R g-rwx,-rwx /var/empty
systemctl restart sshd