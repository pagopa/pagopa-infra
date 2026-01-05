## Google Chrome Update
##
$Path = $env:TEMP;
$Installer = "chrome_installer.exe";
Invoke-WebRequest "https://dl.google.com/chrome/install/latest/chrome_installer.exe" -OutFile $Path\$Installer;
Start-Process -FilePath $Path\$Installer -Args "/silent /install" -Verb RunAs -Wait;
Remove-Item $Path\$Installer

## Windows update last security and reboot 
##
Install-Module -Name PSWindowsUpdate -Force
# Print Update Available
Get-WUList -MicrosoftUpdate
Install-WindowsUpdate -MicrosoftUpdate -AcceptAll -AutoReboot