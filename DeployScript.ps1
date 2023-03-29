Install-WindowsFeature NET-Framework-Features
Install-WindowsFeature RSAT-SNMP
Install-WindowsFeature -Name Web-Server -IncludeManagementTools

# Install Applications using Winget

$winget = https://github.com/microsoft/winget-cli/releases/latest/download/Microsoft.DesktopAppInstaller_8wekyb3d8bbwe.appxbundle
Invoke-WebRequest $winget -OutFile "winget.appxbundle"
Add-AppxPackage .\winget.appxbundle

# Install Notepad++
winget install notepadplusplus
