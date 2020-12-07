diskpart list disk
diskpart select disk 2
diskpart clean
diskpart create partition primary
diskpart select partition 1
diskpart format fs=ntfs quick
diskpart active
exit
xcopy F:\*.* E:\ /s /e /f
F:\Boot\Bootsect /NT60 E: /force /mbr