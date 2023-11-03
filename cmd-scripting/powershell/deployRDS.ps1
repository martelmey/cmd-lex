#########################
# Config RDS
# 20210208 Martel Meyers
#########################

collection="KDC-PRD-OPS"
broker="kutlprdsolar01.sws.health.local"
waccess="kutlprdsolar01.sws.health.local"
rdsh1="kutlprdops01.sws.health.local"
rdsh2="kutlnpops01.sws.health.local"
rdsh3="cutlprdops01.sws.health.local"
rdsh4="cutlmgtops01.sws.health.local"

# On broker
Import-Module RemoteDesktop
New-SessionDeployment -ConnectionBroker $broker -WebAccessServer $waccess -SessionHost $rdsh1
New-RDSessionCollection -CollectionName "KDC-PRD-OPS" -SessionHost $rdsh1 -ConnectionBroker $broker
New-RDSessionCollection -CollectionName "KDC-NP-OPS" -SessionHost $rdsh2 -ConnectionBroker $broker
New-RDSessionCollection -CollectionName "CDC-PRD-OPS" -SessionHost $rdsh3 -ConnectionBroker $broker
New-RDSessionCollection -CollectionName "CDC-NP-OPS" -SessionHost $rdsh4 -ConnectionBroker $broker
# access for SWS\Operations, SWS\SolarWinds Admins for all collections
Add-RDSessionHost -CollectionName $collection -SessionHost $rdsh1 -ConnectionBroker $broker
Add-RDServer -Server $rdsh2 -Role "RDS-RD-SERVER" -ConnectionBroker $broker

# On rdsh
Set-DnsClientServerAddress -InterfaceAlias "Ethernet" -ServerAddress ("192.168.60.192","192.168.160.197")
Set-DnsClientServerAddress -InterfaceAlias "Ethernet 2" -ServerAddress ("")
Set-DnsClientServerAddress -InterfaceAlias "Ethernet 3" -ServerAddress ("")
# secpol allow RDS: Administrators, Remote Desktop Users
# local Remote Desktop Users group +SWS\Operations, +SWS\SolarWinds Admins
ipconfig /flushdns
Set-ItemProperty -Path "HKLM\SOFTWARE\Policies\Microsoft\Windows NT\Terminal Services" LicenseServers -Value "192.168.60.201"
Set-ItemProperty -Path "HKLM\SOFTWARE\Policies\Microsoft\Windows NT\Terminal Services" LicensingMode -Value 4