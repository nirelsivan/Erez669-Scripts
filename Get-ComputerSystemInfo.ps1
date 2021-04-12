# Local and Remote System Information v3
# Shows details of currently running PC
# Thom McKiernan 11/09/2014 and modified by Erez Schwartz

while ($true)
{
$ErrorActionPreference = 'SilentlyContinue'
write-host "`n" # for creating space
write-host "Get Computer Hardware Information"
write-host "`n" # for creating space
$enterPC = read-host "enter Computername or IP Address"
$computerSystem = Get-CimInstance CIM_ComputerSystem –ComputerName $enterPC
$computerBIOS = Get-CimInstance CIM_BIOSElement –ComputerName $enterPC
$computerOS = Get-CimInstance CIM_OperatingSystem –ComputerName $enterPC
$computerCPU = Get-CimInstance CIM_Processor –ComputerName $enterPC
$computerHDD = Get-CimInstance Win32_LogicalDisk -Filter "DeviceID = 'C:'" –ComputerName $enterPC
$DiskType = Get-PhysicalDisk -CimSession $enterPC | select mediatype

# ---------------------------------------------------------------------------
#   					Enable Remote Registry Service
# ---------------------------------------------------------------------------

$Service = "RemoteRegistry"
$RemoteRegistry = Get-CimInstance -Class Win32_Service -ComputerName $enterPC -Filter 'Name = "$Service"'
Set-Service -Name $Service -ComputerName $enterPC -StartupType Automatic
Start-Service -InputObject (Get-Service -Name $Service -ComputerName $enterPC)

Clear-Host

Write-Host "System Information for: " $computerSystem.Name -BackgroundColor DarkCyan
"Manufacturer: " + $computerSystem.Manufacturer
"Model: " + $computerSystem.Model
"Serial Number: " + $computerBIOS.SerialNumber
"CPU: " + $computerCPU.Name
"HDD Capacity: "  + "{0:N2}" -f ($computerHDD.Size/1GB) + "GB" + "$DiskType"
"HDD Space: " + "{0:P2}" -f ($computerHDD.FreeSpace/$computerHDD.Size) + " Free (" + "{0:N2}" -f ($computerHDD.FreeSpace/1GB) + "GB)"
"RAM: " + "{0:N2}" -f ($computerSystem.TotalPhysicalMemory/1GB) + "GB"
"Operating System: " + $computerOS.caption
Reg Query "\\$enterPC\HKLM\SOFTWARE\Microsoft\Windows NT\CurrentVersion" /v ReleaseId
write-host "`n" # for creating space
write-host "Original Install Date"
write-host "`n" # for creating space
([WMI] "").ConvertToDateTime(((Get-WmiObject -class win32_operatingsystem -ComputerName $enterPC).installdate))
write-host "`n" # for creating space
"User logged In: " + $computerSystem.UserName
"Last Reboot: " + $computerOS.LastBootUpTime
}