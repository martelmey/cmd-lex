$SourceExe = "C:\Program Files (x86)\Vim\vim82"
$DestinationPath = "C:\Users\Administrator.KUTLPRDOPS01\Desktop\vim.lnk"

$SourceExe = "C:\eclipse\jee-2020-092\eclipse\eclipse.exe"
$DestinationPath = "C:\Users\Public\Public Desktop\eclipse.lnk"

$WshShell = New-Object -comObject WScript.Shell
$Shortcut = $WshShell.CreateShortcut($DestinationPath)
$Shortcut.TargetPath = $SourceExe
$Shortcut.Save()

New-Item -ItemType SymbolicLink -Path "C:\Users\Administrator.KUTLPRDOPS01\Desktop" -Name "vim.lnk" -Value "C:\Program Files (x86)\Vim\vim82\vim.exe"
New-Item -ItemType SymbolicLink -Path "C:\Users\Administrator.KUTLPRDOPS01\Desktop" -Name "vimdir.lnk" -Value "C:\Program Files (x86)\Vim\vim82"

New-Item -ItemType SymbolicLink -Path "C:\Users\Public\Desktop" -Name "eclipse.lnk" -Value "C:\eclipse\jee-2020-092\eclipse\eclipse.exe"