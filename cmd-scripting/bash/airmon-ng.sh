airmon-ng check wlan1
macchanger -r wlan1

ifconfig wlan1 down
iwconfig wlan mode monitor
ifconfig wlan1 up
iwconfig wlan1 | grep Mode
airmon-ng start wlan1

airodump-ng wlan1