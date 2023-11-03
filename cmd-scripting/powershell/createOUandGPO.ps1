# create PLIS Users OU
# create GPO PLIS Users in this domain, and Link it here... PLIS Users OU
# Computer Config > Windows Settings > Security Settings > Account Policies > Password Policy
# Maximum password age = 90 days, Minimum password age = 3 days, Enforce password history = 5
# Enforce PLIS Users GPO

Get-ADUser –Identity username –Properties msDS-UserPasswordExpiryTimeComputed|Select-Object -Property Name, @{Name="ExpiryDate";Expression={[datetime]::FromFileTime($_.msDS-UserPasswordExpiryTimeComputed)}}