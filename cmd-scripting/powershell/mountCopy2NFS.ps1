# mountNFS
$passplain = "hialplis_N95"
$passsecure = $passplain | ConvertTo-SecureString -AsPlainText -Force
$username = "KUTLPRDSOLSQL01\Administrator"
$cred = New-Object System.Management.Automation.PSCredential `
    -ArgumentList $username, $passsecure
New-PSDrive -Name "A" -Root "\\192.168.61.132\export\utilities-kdcprd\pkgs\MSSQL-SSO-TESTING" -Scope Global -Persist -PSProvider FileSystem -Credential $cred

# copy2NFS
if(!(Test-Path A:)){
    $passplain = "RHCg12b6qnWf6X1kx9Oo"
    $passsecure = $passplain | ConvertTo-SecureString -AsPlainText -Force
    $username = "KUTLPRDSOLSQL01\Administrator"
    $cred = New-Object System.Management.Automation.PSCredential `
        -ArgumentList $username, $passsecure
    New-PSDrive -Name "B" -Root "\\192.168.56.73\export\sol-ms_sql\db01" -Scope Global -Persist -PSProvider FileSystem -Credential $cred
}
Copy-Item "C:\Program Files\Microsoft SQL Server\MSSQL15.SWSSQLSERVER\MSSQL\Backup\*" -Destination "B:\"
Copy-Item "C:\Program Files\Microsoft SQL Server\MSSQL15.NTASQLSERVER\MSSQL\Backup\*" -Destination "B:\"
Remove-Item -Path "C:\Program Files\Microsoft SQL Server\MSSQL15.SWSSQLSERVER\MSSQL\Backup\*" -Force
Remove-Item -Path "C:\Program Files\Microsoft SQL Server\MSSQL15.NTASQLSERVER\MSSQL\Backup\*" -Force

# cmd equivalent
mount \\192.168.56.73\export\sol-ms_sql\db01 G:
C:
copy "\Program Files\Microsoft SQL Server\MSSQL15.SWSSQLSERVER\MSSQL\Backup\*.*" g:\MSSQL15.SWSSQLSERVER\
copy  "\Program Files\Microsoft SQL Server\MSSQL15.NTASQLSERVER\MSSQL\Backup\*.*" g:\MSSQL15.NTASQLSERVER\