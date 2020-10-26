$users = @(
    'mani.polisetty'
    'aditya.sharma'
    'wes.kubo'
    'saumil.surati'
    'adam.lawerence'
    'kai.du'
    'kristy.vidal'
    'leonardo.garland'
    'navdeep.singh'
    'leonardo.arbelaez'
    'emmanuel.comia'
    'manish.goswami'
    'shankar.sethuraman'
    'alistair.zhu'
    )

For ($i=0; $i -lt $users.Length; $i++) {
    New-LocalUser -Name "$i" -Password "hialplis_N95" -FullName "$i" -AccountNeverExpires -PasswordNeverExpires
    Add-LocalGroupMember -Group "Remote Desktop Users" -Member "$i"
}