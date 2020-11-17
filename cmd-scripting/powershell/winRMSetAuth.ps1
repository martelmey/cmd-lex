# https://devblogs.microsoft.com/powershell/compromising-yourself-with-winrms-allowunencrypted-true/

# Remote server-side

winrm set winrm/config/client/auth @{Basic="true"}
winrm set winrm/config/service/auth @{Basic="true"}
winrm set winrm/config/service @{AllowUnencrypted="true"}