#!/bin/bash

systemctl stop wpa_supplicant.service
cp /etc/wpa_supplicant/wpa_supplicant.conf /etc/wpa_supplicant/wpa_supplicant.conf.old
(
    echo "network={"
    echo '  ssid="RECKLESS_MXANALOG"'
    echo "  scan_ssid=1"
    echo '  psk="***"'
    echo "  key_mgmt=WPA-PSK"
    echo "}"
)>>/etc/wpa_supplicant/wpa_supplicant.conf
reboot