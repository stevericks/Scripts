# This scrpt will install Chocolatey Package Manager, update installed applications including Windows and Office then restart the computer on completion
# Requires the Windows Update PowerShell Module - https://www.powershellgallery.com/packages/PSWindowsUpdate/2.2.0.2

# Enable and Start Services
Write-Host "Enabling and Starting Services"
Set-Service -Name bits -StartupType Automatic
Set-Service -Name wuauserv -StartupType Automatic
Set-Service -Name ClickToRunSvc -DisplayName "Microsoft Office Click-to-Run Service" -StartupType Automatic
Start-Service -Name bits
Start-Service -Name wuauserv
Start-Service -Name ClickToRunSvc

# Install Chocolatey Package Manager
Write-Host "Installing Chocolatey Package Manager"
[System.Net.ServicePointManager]::SecurityProtocol = [System.Net.ServicePointManager]::SecurityProtocol -bor 3072; iex ((New-Object System.Net.WebClient).DownloadString('https://chocolatey.org/install.ps1'))

# Update Adobe Actobat Reader DC
Write-Host "Updating Adobe Acrobat Reader DC"
choco upgrade adobereader -y -yes -confirm

# Update Microsoft Edge
# Write-Host "Updating Microsoft Edge"
# choco upgrade microsoft-edge -y -yes -confirm

# Update Google Chrome
Write-Host "Updating Google Chrome"
choco upgrade googlechrome -y -yes -confirm

# Update Cisco Jabber
Write-Host "Updating Cisco Jabber"
choco upgrade jabber -y -yes -confirm

# Update Lastpass
Write-Host "Updating Lastpass"
choco upgrade Lastpass -y -yes -confirm

# Update FSLogix
# Write-Host "Updating FSLogix"
# choco upgrade fslogix -y -yes -confirm

# Update FSLogix RuleEditor
# Write-Host "Updating FSLogix RuleEditor"
# choco upgrade fslogix-rule -y -yes -confirm

# Update FSLogix Java RuleEditor
# Write-Host "Updating FSLogix java RuleEditor"
# choco upgrade fslogix-java -y -yes -confirm

# Update Microsoft OneDrive
# Write-Host "Updating Microsoft OneDrive"
# choco upgrade onedrive -y -yes -confirm

# Update Power BI Desktop
Write-Host "Updating Power BI Desktop"
choco upgrade powerbi -y -yes -confirm

# Update Microsoft Teams Desktop (Machine Wide Install)
Write-Host "Updating Microsoft Teams Desktop (Machine Wide Install)"
choco upgrade microsoft-teams.install -y -yes -confirm

# Update Mozilla Firefox
# Write-Host "Updating Mozilla Firefox"
# choco upgrade firefoxesr -y -yes -confirm --params "/l:en-GB /NoTaskbarShortcut /NoDesktopShortcut /NoAutoUpdate /RemoveDistributionDir"

# Update VLC Media Player
# Write-Host "Updating VLC Media Player"
# choco upgrade vlc -y -yes -confirm

# Update GIMP
# Write-Host "Updating GIMP"
# choco upgrade gimp -y -yes -confirm

# Update Windows
Write-Host "Updating Windows"
Import-Module PSWindowsUpdate
Get-WUInstall -Install -AcceptAll -IgnoreReboot

# Update Microsoft Office
Write-Host "Updating Microsoft Office"
cd "C:\Program Files\Common Files\microsoft shared\ClickToRun"
.\OfficeC2RClient.exe /update user displaylevel=false forceappshutdown=true

# Sleep for 5 minutes before proceeding with the next task
Write-Host "Waiting for operation to complete"
Start-Sleep -s 300