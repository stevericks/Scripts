$disk = Get-Disk -Number 2
Initialize-Disk -InputObject $disk -PartitionStyle MBR
New-Partition -DiskNumber $disk.Number -UseMaximumSize -DriveLetter F
Format-Volume -DriveLetter F -FileSystem NTFS -NewFileSystemLabel "Data"

# Add Welcom Share
New-Item -ItemType Directory -Path "F:\Welcom"
New-SmbShare -Name "WelcomShare" -Path "F:\Welcom" -ReadAccess "Domain Users" -FullAccess "Domain Admins", "Welcom"
