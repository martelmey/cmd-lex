$PlainPassword = "P@ssw0rd"
$SecurePassword = $PlainPassword | ConvertTo-SecureString -AsPlainText -Force
$UserName = "Domain\User"
$Credentials = New-Object System.Management.Automation.PSCredential `
     -ArgumentList $UserName, $SecurePassword