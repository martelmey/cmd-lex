
### Test team

New-LocalUser -Name "aditya.sharma" -Password "hialplis_N95" -FullName "aditya.sharma" -AccountNeverExpires -PasswordNeverExpires
Add-LocalGroupMember -Group "Remote Desktop Users" -Member "aditya.sharma"

New-LocalUser -Name "mani.polisetty" -Password "hialplis_N95" -FullName "mani.polisetty" -AccountNeverExpires -PasswordNeverExpires
Add-LocalGroupMember -Group "Remote Desktop Users" -Member "mani.polisetty"

New-LocalUser -Name "wes.kubo" -Password "hialplis_N95" -FullName "wes.kubo" -AccountNeverExpires -PasswordNeverExpires
Add-LocalGroupMember -Group "Remote Desktop Users" -Member "wes.kubo"

New-LocalUser -Name "saumil.surati" -Password "hialplis_N95" -FullName "saumil.surati" -AccountNeverExpires -PasswordNeverExpires
Add-LocalGroupMember -Group "Remote Desktop Users" -Member "saumil.surati"

New-LocalUser -Name "kai.du" -Password "hialplis_N95" -FullName "kai.du" -AccountNeverExpires -PasswordNeverExpires
Add-LocalGroupMember -Group "Remote Desktop Users" -Member "kai.du"

New-LocalUser -Name "adam.lawerence" -Password "hialplis_N95" -FullName "adam.lawerence" -AccountNeverExpires -PasswordNeverExpires
Add-LocalGroupMember -Group "Remote Desktop Users" -Member "adam.lawerence"

### DB team

New-LocalUser -Name "kristy.vidal" -Password "hialplis_N95" -FullName "kristy.vidal" -AccountNeverExpires -PasswordNeverExpires
Add-LocalGroupMember -Group "Remote Desktop Users" -Member "kristy.vidal"

New-LocalUser -Name "leonardo.garland" -Password "hialplis_N95" -FullName "leonardo.garland" -AccountNeverExpires -PasswordNeverExpires
Add-LocalGroupMember -Group "Remote Desktop Users" -Member "leonardo.garland"

New-LocalUser -Name "leonardo.arbelaez" -Password "hialplis_N95" -FullName "leonardo.arbelaez" -AccountNeverExpires -PasswordNeverExpires
Add-LocalGroupMember -Group "Remote Desktop Users" -Member "leonardo.arbelaez"

New-LocalUser -Name "navdeep.singh" -Password "hialplis_N95" -FullName "navdeep.singh" -AccountNeverExpires -PasswordNeverExpires
Add-LocalGroupMember -Group "Remote Desktop Users" -Member "navdeep.singh"

### App deployment team - TBD

$Password = Read-Host -AsSecureString

New-LocalUser -Name "emmanuel.comia" -Password $Password -FullName "emmanuel.comia" -AccountNeverExpires -PasswordNeverExpires
Add-LocalGroupMember -Group "Remote Desktop Users" -Member "emmanuel.comia"

New-LocalUser -Name "manish.goswami" -Password $Password -FullName "manish.goswami" -AccountNeverExpires -PasswordNeverExpires
Add-LocalGroupMember -Group "Remote Desktop Users" -Member "manish.goswami"

New-LocalUser -Name "shankar.sethuraman" -Password $Password -FullName "shankar.sethuraman" -AccountNeverExpires -PasswordNeverExpires
Add-LocalGroupMember -Group "Remote Desktop Users" -Member "shankar.sethuraman"