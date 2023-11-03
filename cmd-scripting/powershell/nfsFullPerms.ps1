# uid=1000023(martel.meyers) gid=1011(cgistaff)
# chown -R martel.meyers:cgistaff kvm-backups
New-ItemProperty HKLM:\SOFTWARE\Microsoft\ClientForNFS\CurrentVersion\Default -Name AnonymousUID -Value 1000023 -PropertyType "DWord"
New-ItemProperty HKLM:\SOFTWARE\Microsoft\ClientForNFS\CurrentVersion\Default -Name AnonymousGID -Value 1011 -PropertyType "DWord"
shutdown /r /f /t 0
mount -o anon 192.168.61.132:/export/utilities-kdcprd/pkgs/kvm-backups/
mount -o anon 192.168.156.70:/export/utilities-cdcprd/pkgs/kvm-backups/