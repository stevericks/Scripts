Install-WindowsFeature NET-Framework-Features
Install-WindowsFeature RSAT-SNMP
Install-WindowsFeature -Name Web-Server -IncludeManagementTools

#Initialise Disk 2
$disk = Get-Disk -Number 2
Initialize-Disk -InputObject $disk -PartitionStyle MBR
New-Partition -DiskNumber $disk.Number -UseMaximumSize -DriveLetter F
Format-Volume -DriveLetter F -FileSystem NTFS -NewFileSystemLabel "Data"

#Set home location to the United Kingdom
Set-WinHomeLocation 0xf2

#override language list with just English GB
$1 = New-WinUserLanguageList en-GB
$1[0].Handwriting = 1
Set-WinUserLanguageList $1 -force

#Set system local
Set-WinSystemLocale en-GB

#Set the timezone
Set-TimeZone "GMT Standard Time"

# Add Welcom Share
# New-Item -ItemType Directory -Path "F:\Welcom"
# New-SmbShare -Name "WelcomShare" -Path "F:\Welcom" -ReadAccess "Domain Users" -FullAccess "Domain Admins", "Welcom"
