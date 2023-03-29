Install-WindowsFeature NET-Framework-Features
Install-WindowsFeature RSAT-SNMP
Install-WindowsFeature -Name Web-Server -IncludeManagementTools

# This scrpt will install Chocolatey Package Manager, update installed applications then restart the computer on completion

# Enable and Start Services
Write-Host "Enabling and Starting Services"
Set-Service -Name bits -StartupType Automatic
Set-Service -Name wuauserv -StartupType Automatic
Start-Service -Name bits
Start-Service -Name wuauserv

# Install Chocolatey Package Manager
Write-Host "Installing Chocolatey Package Manager"
[System.Net.ServicePointManager]::SecurityProtocol = [System.Net.ServicePointManager]::SecurityProtocol -bor 3072; iex ((New-Object System.Net.WebClient).DownloadString('https://chocolatey.org/install.ps1'))

# Update Adobe Actobat Reader DC
Write-Host "Updating Adobe Acrobat Reader DC"
choco upgrade adobereader -y -yes -confirm

# Update Microsoft Edge
Write-Host "Updating Microsoft Edge"
choco upgrade microsoft-edge -y -yes -confirm

# Update Google Chrome
Write-Host "Updating Google Chrome"
choco upgrade googlechrome -y -yes -confirm

# This script will stop relevant services/tasks, uninstall Chocolatey Package Manager, clean up the OS then restart the Server.

# Stop and Disable Services
Write-Host "Stopping and Disabling Services"
Stop-Service -Name bits
Stop-Service -Name wuauserv
Set-Service -Name bits -StartupType Disabled
Set-Service -Name wuauserv -StartupType Disabled
Set-Service -Name gupdate -DisplayName "Google Update Service (gupdate)" -StartupType Disabled
Set-Service -Name gupdatem -DisplayName "Google Update Service (gupdatem)" -StartupType Disabled
Set-Service -Name edgeupdate -DisplayName "Microsoft Edge Update Service (edgeupdate)" -StartupType Disabled
Set-Service -Name edgeupdatem -DisplayName "Microsoft Edge Update Service (edgeupdatem)" -StartupType Disabled

# Disable Scheduled Tasks
Write-Host "Disabling Scheduled Tasks"
Disable-ScheduledTask -TaskName "Adobe Acrobat Update Task"
Disable-ScheduledTask -TaskName "GoogleUpdateTaskMachineCore"
Disable-ScheduledTask -TaskName "GoogleUpdateTaskMachineUA"
Disable-ScheduledTask -TaskName "MicrosoftEdgeUpdateTaskMachineCore"
Disable-ScheduledTask -TaskName "MicrosoftEdgeUpdateTaskMachineUA"

# Uninstall Chocolatey Package Manager
Write-Host "Uninstalling Chocolatey Package Manager"
Remove-Item -Path "C:\ProgramData\chocolatey" -Recurse -Force

# Clean up Image
Write-Host "Cleaning up Image"
# Remove-Item -Path "C:\Users\Public\Desktop\*" -Recurse -Force
Remove-Item -Path $Env:TEMP\* -Recurse -Force
Remove-Item -Path "C:\Windows\Temp\*" -Recurse -Force
Remove-Item -Path "C:\Windows\SoftwareDistribution\*" -Recurse -Force

# Set Execution Policy
Write-Host "Setting PowerShell Execution Policy to Restricted"
Set-ExecutionPolicy Restricted -Force

# Reboot Server
Write-Host "Rebooting Server"
Restart-Computer -ComputerName localhost
