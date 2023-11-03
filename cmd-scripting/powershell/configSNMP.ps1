install-windowsfeature -name SNMP-Service
Set-Service -Name snmp -StartupType 'Automatic'

#properties>agent>service>check off all
#properties>security>add public ro>accept from these hosts