#Change date format 

$culture = (Get-Culture).Clone()
$culture.DateTimeFormat.ShortDatePattern = ‘dd/MM/yyyy’
Set-Culture $culture

#Change timezone and region 

#Set home location to United Kingdom
Set-WinHomeLocation 0xf2

#override language list with just English GB
$1 = New-WinUserLanguageList en-GB
$1[0].Handwriting = 1
Set-WinUserLanguageList $1 -force

#Set system local
Set-WinSystemLocale en-GB

#Set the timezone
Set-TimeZone “GMT Standard Time”

#Restart the OS