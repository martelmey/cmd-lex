Import-Module ADDSDeployment
Uninstall-ADDSDomainController `
-DemoteOperationMasterRole:$true `
-RemoveDnsDelegation:$true `
-Force:$true