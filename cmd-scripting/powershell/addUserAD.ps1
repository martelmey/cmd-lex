New-ADUser -Name nbu_svc_exch -AccountPassword $(ConvertTo-SecureString "P@ssw0rd" -AsPlainText -Force) -UserPrincipalName nbu_svc_exch@vrtsedu.lab -Enabled $true -CannotChangePassword $true -ChangePasswordAtLogon $false -PasswordNeverExpires $true

Get-ADUser -Identity nbu_svc_exch

Add-ADGroupMember -Identity "Organization Management" -Members nbu_svc_exch

Get-ADGroupMember -Identity "Organization Management"