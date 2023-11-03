#########################
# Config DNS & AD DS
# 20210208 Martel Meyers
#########################

# Match the interface w/ mgmt address, pass to get-netadapter
Get-NetAdapter Ethernet | Set-DNSClient –RegisterThisConnectionsAddress $True
Get-NetAdapter "Ethernet 2" | Set-DNSClient –RegisterThisConnectionsAddress $False
Get-NetAdapter "Ethernet 3" | Set-DNSClient –RegisterThisConnectionsAddress $False
Set-DNSClientServerAddress -InterfaceAlias Ethernet -ServerAddress ("192.168.60.201","192.168.60.251")
Set-DNSClientServerAddress -InterfaceAlias "Ethernet 2" -ServerAddress ("127.0.0.1")
Set-DNSClientServerAddress -InterfaceAlias "Ethernet 3" -ServerAddress ("127.0.0.1")
Install-WindowsFeature -Name DNS
cmd
dnscmd /resetlistenaddresses 192.168.60.192
exit

# For member servers
function Config-MemberServer {
	Set-DnsClientServerAddress -InterfaceAlias "Ethernet" -ServerAddress ("192.168.60.192","192.168.160.197")
	Set-DnsClientServerAddress -InterfaceAlias "Ethernet 2" -ServerAddress ("")
	Set-DnsClientServerAddress -InterfaceAlias "Ethernet 3" -ServerAddress ("")
	# secpol allow RDS: Administrators, Remote Desktop Users
	# local Remote Desktop Users group +SWS\Operations, +SWS\SolarWinds Admins
	ipconfig /flushdns
}

# For new domain:
function New-Forest {
	Install-WindowsFeature -Name AD-Domain-Services
	Import-Module ADDSDeployment
	Install-ADDSForest `
	-CreateDnsDelegation:$false `
	-DatabasePath "C:\Windows\NTDS" `
	-DomainMode "WinThreshold" `
	-DomainName "kdcwin.local" `
	-DomainNetbiosName "KDCWIN" `
	-ForestMode "WinThreshold" `
	-InstallDns:$true `
	-LogPath "C:\Windows\NTDS" `
	-NoRebootOnCompletion:$false `
	-SysvolPath "C:\Windows\SYSVOL" `
	-Force:$true
}

# For secondary DC:
function AddTo-Forest {
	Import-Module ADDSDeployment
	Install-ADDSDomainController `
	-NoGlobalCatalog:$false `
	-CreateDnsDelegation:$false `
	-CriticalReplicationOnly:$false `
	-DatabasePath "C:\Windows\NTDS" `
	-DomainName "sws.health.local" `
	-InstallDns:$true `
	-LogPath "C:\Windows\NTDS" `
	-NoRebootOnCompletion:$false `
	-ReplicationSourceDC "kutlprdsolar01.sws.health.local" `
	-SiteName "KDC" `
	-SysvolPath "C:\Windows\SYSVOL" `
	-Force:$true
}

