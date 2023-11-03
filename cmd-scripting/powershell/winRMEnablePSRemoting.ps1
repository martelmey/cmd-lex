cmd
winrm set winrm/config/client/auth @{Basic="true"}
winrm set winrm/config/client/auth @{CredSSP="true"}
winrm set winrm/config/client @{AllowUnencrypted="true"}
winrm set winrm/config/service/auth @{Basic="true"}
winrm set winrm/config/service/auth @{CredSSP="true"}
winrm set winrm/config/service @{AllowUnencrypted="true"}
exit
Set-Item WSMan:\localhost\Client\TrustedHosts -Value '*'
Enable-PSRemoting -Force

# Testing
setspn -l <hostname>
netsh winhttp show proxy --> netsh winhttp reset proxy

winrm get winrm/config/client
winrm get winrm/config/service
winrm enumerate winrm/config/listener

netstat -oan --> look for 5985 listening

invoke-command -computername 192.168.60.192 -credential Administrator -scriptblock { ipconfig }

Test-WsMan 192.168.60.192
