#!/bin/bash

INT_WIFI="wlan0"
EXT_WIFI="wlan1"
AP_NAME="sinister-chalister"
WPA_PASS="deviant_pk"
ANNOUNCE="[SINISTER-SETUP] :"

EXISTS_WLAN0=
EXISTS_WLAN1=

ifconfig | grep wlan0
if [[ $? -eq 0 ]]; then
	$EXISTS_WLAN0=1
fi

ifconfig | grep wlan1
if [[ $? -eq 0 ]]; then
	$EXISTS_WLAN1=1
fi

if [[ $EXISTS_WLAN0 -eq 1 && $EXISTS_WLAN1 -eq 1 ]]; then
	echo "$ANNOUNCE Installing deps ... "
	sleep 2
	apt update && apt -y upgrade && apt -y hostapd dnsmasq

	echo "$ANNOUNCE Releasing wlan1 from NM_CONTROLLED ... "
	sleep 2
	cp /etc/NetworkManager/NetworkManager.conf /etc/NetworkManager/NetworkManager.conf.old
	(
		echo '[keyfile]'
		echo 'unmanaged-devices=interface-name:$"EXT_WIFI"'
	)>>/etc/NetworkManager/NetworkManager.conf
	systemctl restart NetworkManager

	echo "$ANNOUNCE Creating /root/ap/ ..."
	sleep 2
	mkdir /root/ap

	echo "$ANNOUNCE Spawning /root/ap/dnsmasq.conf ..."
	sleep 2
	touch /root/ap/dnsmasq.conf
	(
		echo 'interface="#EXT_WIFI"'
		echo "dhcp-range=192.168.1.2,192.168.1.30,255.255.255.0,12h"
		echo "dhcp-option=3,192.168.1.1"
		echo "dhcp-option=6,192.168.1.1"
		echo "server=8.8.8.8"
		echo "log-queries"
		echo "log-dhcp"
		echo "listen-address=127.0.0.1"
	)>>/root/ap/dnsmasq.conf

	echo "$ANNOUNCE Spawning /root/ap/hostapd.conf ... "
	sleep 2
	touch /root/ap/hostapd.conf
	(
		echo 'interface="$EXT_WIFI"'
		echo "driver=nl80211"
		echo 'ssid="$AP_NAME"'
		echo "hw_mode=g"
		echo "channel=6"
		echo "macaddr_acl=0"
		echo "ignore_broadcast_ssid=0"
		echo "auth_algs=1"
		echo "wpa=2"
		echo "wpa_key_mgmt=WPA-PSK"
		echo "rsn_pairwise=TKIP"
		echo 'wpa_passphrase="$WPA_PASS"'
	)>>/root/ap/hostapd.conf

	echo "$ANNOUNCE "
	ifconfig "$EXT_WIFI" down
	iwconfig "$EXT_WIFI" mode monitor
	ifconfig "$EXT_WIFI" up
	ifconfig "$EXT_WIFI" up 192.168.1.1 netmask 255.255.255.0
	route add -net 192.168.1.0 netmask 255.255.255.0 gw 192.168.1.1
	iptables --table nat --append POSTROUTING --out-interface "$INT_WIFI" -j MASQUERADE
	iptables --append FORWARD --in-interface "$EXT_WIFI" -j ACCEPT
	echo 1 > /proc/sys/net/ipv4/ip_forward
else
	echo "$ANNOUNCE wlan0 & wlan1 interfaces must be present. Try again."
fi