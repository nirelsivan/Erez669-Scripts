New-Item "HKCU:\Software\Microsoft\Windows\CurrentVersion\Internet Settings\ZoneMap\Ranges\Range1"
Set-Location "HKCU:\Software\Microsoft\Windows\CurrentVersion\Internet Settings\ZoneMap\Ranges\Range1"
New-ItemProperty . -Name :Range -value 10.251.1-254.* -type String
New-ItemProperty . -Name * -value 1 -type DWORD