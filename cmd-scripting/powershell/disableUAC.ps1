Set-ItemProperty -Path "HKLM:\SOFTWARE\Microsoft\Windows\CurrentVersion\policies\system\" -Name EnableLUA -Value 0
Restart-Computer -Force