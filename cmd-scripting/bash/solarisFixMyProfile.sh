#!/bin/bash
mkdir /export/home/martel.meyers
touch /export/home/martel.meyers/.bash_history
cp /root/.bashrc /export/home/martel.meyers
cp /root/.profile /export/home/martel.meyers/
usermod -G staff,adm,cgiadmin,cgistaff martel.meyers
chown -R martel.meyers:cgiadmin /export/home/martel.meyers
