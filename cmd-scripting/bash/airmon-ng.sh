
ifconfig wlan1 down
macchanger -r wlan1
airmon-ng check wlan1
# kill PIDs: NetworkManager, wpa_supplicant
iwconfig wlan mode monitor
ifconfig wlan1 up
iwconfig wlan1 | grep Mode
airmon-ng start wlan1

airodump-ng wlan1