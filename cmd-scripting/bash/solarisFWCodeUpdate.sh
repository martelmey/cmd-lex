#!/bin/bash

# 1. Stage the patch files
mkdir /var/tmp/Fortpond
cp ~matthew.stanley/p28729747_100_Generic.zip /var/tmp/Fortpond/
cd /var/tmp/Fortpond
unzip p28729747_100_Generic.zip 

# 2. Login from SP/ILOM console, check/set /HOST/diag
-> set /HOST/diag default_level=min
#Set 'default_level' to 'min'
-> set /HOST/diag hw_change_level=min 
#Set 'hw_change_level' to 'min'
-> show /HOST/diag
# /HOST/diag
#    Targets:
#    Properties:
#        default_level = min
#        default_verbosity = normal
#        error_level = max
#        error_verbosity = normal
#        hw_change_level = min
#        hw_change_verbosity = normal
-> 

# 3. Stop all LDOMs
ldm ls
ldm stop knpapp11
ldm stop knpapp12
ldm stop knpapp13

# 4. Double check LDOMs config is current and save if needed
ldm ls-config
ldm add-spconfig 2021-03-04-pre_fcode

# 5. Run FW update (from /var/tmp/Fortpond)
fwupdate list all
fwupdate update all -x metadata.xml
#The following actions will be taken:
#==========================================================
#ID        Priority Action     Status      Old Firmware Ver.   Proposed Ver.       New Firmware Ver.   System Reboot     
#------------------------------------------------------------------------------------------------------------------------
#c3        1        Check FW   Success     80003072            80003B43            N/A                 System Power Cycle
#Do you wish to process the above actions? [y/n]? 
#Updating c3:  Success
#Sleeping for 10 seconds for component to recover
#Verifying all priority 1 updates
#Execution Summary
#==========================================================
#ID        Priority Action     Status      Old Firmware Ver.   Proposed Ver.       New Firmware Ver.   System Reboot     
#------------------------------------------------------------------------------------------------------------------------
#c3        1        Post Power Pending     80003072            80003B43            N/A                 System Power Cycle
#System Power Cycle required for some applied firmware
#Do you wish to automatically initiate system power cycle now? [y/n]? y

# 6. Wait for fwupdate to power off (may take 2-3 min) then power back on from SP
-> start /System
#Are you sure you want to start /System (y/n)? y
#Starting /System
-> start /SP/console
#Are you sure you want to start /SP/console (y/n)? y
#Serial console started.  To stop, type #.
#2021-03-04 14:18:59  0:00:0> NOTICE:  Firmware timezone is GMT
#2021-03-04 14:19:00  0:00:0> NOTICE:  TPM is turned off
#2021-03-04 14:19:02  0:00:0> NOTICE:  Validating Configuration
#2021-03-04 14:19:08  1:00:0> NOTICE:  SPARC-M8 Revision 1.1, 5067 MHz
#2021-03-04 14:19:08  0:00:0> NOTICE:  SPARC-M8 Revision 1.1, 5067 MHz
#2021-03-04 14:19:08  1:00:0> NOTICE:  Fab:0 Lot:PK9M46 Wafer:12 Col(X):6 Row(Y):8 TP Rev:PROD B-06
#2021-03-04 14:19:08  0:00:0> NOTICE:  Fab:0 Lot:PK9M46 Wafer:15 Col(X):1 Row(Y):2 TP Rev:PROD B-06
#2021-03-04 14:19:13  0:00:0> NOTICE:  Starting Early POST
#<snip>
#(Wait approx 15 min for power cycle boot for T8-2, will likely be longer for M8)

#7. After boot, check Fcode updated for the card
fwupdate list all
#==================================================
#CONTROLLER
#==================================================
#ID    Type   Manufacturer   Model     Product Name              FW Version     BIOS Version   EFI Version    FCODE Version  Package Version  NVDATA Version    XML Support
#--------------------------------------------------------------------------------------------------------------------------------------------------------------------------
#c3    NET    Intel          0x1589    Oracle Quad Port 10GBase- -              -              2.8.8          3.10.0         80003B43         -                 N/A        
#root@knpappdm01:~# 

#8. After checks, set diag back to max for HW change
-> set /HOST/diag hw_change_level=max
#(done)