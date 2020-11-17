# https://www.dtonias.com/add-computers-trustedhosts-list-powershell/

# DC-side

Get-Item WSMan:\localhost\Client\TrustedHosts
Set-Item WSMan:\localhost\Client\TrustedHosts -Value '192.168.60.192,192.168.60.201,192.168.63.197'   #,[<kutlprdsolar01>]
Set-Item WSMan:\localhost\Client\TrustedHosts -Value '192.168.60.202'