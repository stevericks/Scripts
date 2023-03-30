$disk = Get-Disk -Number 2
Initialize-Disk -InputObject $disk -PartitionStyle MBR
New-Partition -DiskNumber $disk.Number -UseMaximumSize -DriveLetter E
Format-Volume -DriveLetter E -FileSystem NTFS -NewFileSystemLabel "Data"

# Add Welcom Share
New-Item -ItemType Directory -Path "E:\Welcom"
New-SmbShare -Name "WelcomShare" -Path "E:\Welcom" -ReadAccess "Domain Users" -FullAccess "Domain Admins", "Welcom"
