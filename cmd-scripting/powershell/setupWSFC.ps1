Install-WindowsFeature -Name Failover-Clustering -IncludeManagementTools -IncludeAllSubFeature
$cred = New-Object System.Management.Automation.PSCredential -ArgumentList @(‘sws.health.local\martel.meyers’,(ConvertTo-SecureString -String ‘hialplis_N95’ -AsPlainText -Force))
Install-WindowsFeature -Name Failover-Clustering -IncludeManagementTools -IncludeAllSubFeature -ComputerName "cutlprdsolsql01" -Credential $cred
Restart-Computer -ComputerName cutlprdsolsql01 -Force
## DNS
## Create OU, CNO, VCO, ClusterAdmins group
New-ADOrganizationalUnit -Name "WSFC" -Path "DC=sws,DC=health,DC=local"
New-ClusterNameAccount -Name "SWSKDCCDC" -Domain "sws.health.local" -Enabled false
New-ADComputer -Name "SQLServer" -SamAccountName "SQLServer" -Path "OU=WSFC,DC=sws,DC=health,DC=local"
New-ADGroup -Name "ClusterAdmins" -SamAccountName "ClusterAdmins" -GroupCategory Security -GroupScope Global -DisplayName "ClusterAdmins" -Path "OU=WSFC,DC=sws,DC=health,DC=local"
## Add members to ClusterAdmins, Account Operators, Domain Admins
Add-ADGroupMember -Identity "ClusterAdmins" -Members "sws.health.local/Users/Administrator","sws.health.local/Computers/KUTLPRDSOLSQL01","sws.health.local/Computers/CUTLPRDSOLSQL01","sws.health.local/WSFC/SWSKDCCDC"
Add-ADGroupMember -Identity "Account Operators" -Members "sws.health.local/Users/Administrator","sws.health.local/Computers/KUTLPRDSOLSQL01","sws.health.local/Computers/CUTLPRDSOLSQL01","sws.health.local/WSFC/SWSKDCCDC"
Add-ADGroupMember -Identity "Domain Admins" -Members "sws.health.local/Users/Administrator","sws.health.local/Computers/KUTLPRDSOLSQL01","sws.health.local/Computers/CUTLPRDSOLSQL01","sws.health.local/WSFC/SWSKDCCDC"
## Set security permissions
## Create cluster
New-Cluster -Name SWSKDCCDC -Node -ManagementPointNetworkType Distributed kutlprdsolsql01,cutlprdsolsql01
Get-ADObject -Filter * | Where{($_.ObjectClass -eq “container”) -or ($_.ObjectClass -eq “organizationalunit”) -or ($_.ObjectClass -eq “user”) -or ($_.ObjectClass -eq “group”) -or ($_.ObjectClass -eq “computer”)} | Set-ADObject -ProtectedFromAccidentalDeletion $true
Start-ClusterNode -Name kutlprdsolsql01
Start-ClusterNode -Name cutlprdsolsql01