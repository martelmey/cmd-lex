wmic useraccount get name,sid
wmic useraccount where name="adam.lawrence" get sid
Get-WmiObject win32_useraccount -Filter "name = 'adam.lawrence' AND domain = 'SWS'"

Remove-ItemProperty -Path "HKEY_USERS\S-1-5-21-754343526-404298208-2692719310-4105\Environment" -Name "JAVA_HOME"