# Local and Remote System Information v4
# Shows details of currently running PC
# written by Erez Schwartz 17.2.23

while ($true)
{
    $ErrorActionPreference = 'SilentlyContinue'
    Write-Host "`n" # for creating space
    Write-Host "Get Computer Hardware Information"
    Write-Host "`n" # for creating space
    $enterPC = Read-Host "Enter Computername or IP Address"
    $computerSystem = Get-WmiObject -Class Win32_ComputerSystem –ComputerName $enterPC
    $computerBIOS = Get-WmiObject -Class Win32_BIOS –ComputerName $enterPC
    $computerOS = Get-WmiObject -Class Win32_OperatingSystem –ComputerName $enterPC
    $computerCPU = Get-WmiObject -Class Win32_Processor –ComputerName $enterPC
    $computerHDD = Get-WmiObject -Class Win32_LogicalDisk -ComputerName $enterPC -Filter "DeviceID = 'C:'"
    $diskType = (Get-PhysicalDisk -CimSession $enterPC | Select-Object MediaType).MediaType

    # ---------------------------------------------------------------------------
    #   					Enable Remote Registry Service
    # ---------------------------------------------------------------------------

$Service = "RemoteRegistry"
$RemoteRegistry = Get-CimInstance -Class Win32_Service -ComputerName $enterPC -Filter "Name = '$Service'"
Set-Service -Name $Service -ComputerName $enterPC -StartupType Automatic
Start-Service -InputObject (Get-Service -Name $Service -ComputerName $enterPC)

Clear-Host
    
    Write-Host "System Information for: " $computerSystem.Name -BackgroundColor DarkCyan
    "Manufacturer: " + $computerSystem.Manufacturer
    "Model: " + $computerSystem.Model
    "Serial Number: " + $computerBIOS.SerialNumber
    "CPU: " + $computerCPU.Name
    "HDD Capacity: "  + "{0:N2}" -f ($computerHDD.Size/1GB) + "GB"
    "HDD Type: " + $diskType
    "HDD Space: " + "{0:P2}" -f ($computerHDD.FreeSpace/$computerHDD.Size) + " Free (" + "{0:N2}" -f ($computerHDD.FreeSpace/1GB) + "GB)"
    "RAM: " + "{0:N2}" -f ($computerSystem.TotalPhysicalMemory/1GB) + "GB"
    "Operating System: " + $computerOS.caption
    Reg Query "\\$enterPC\HKLM\SOFTWARE\Microsoft\Windows NT\CurrentVersion" /v ReleaseId
    Write-Host "`n" # for creating space
    Write-Host "Original Install Date"
    Write-Host "`n" # for creating space
    ([WMI] "").ConvertToDateTime(((Get-WmiObject -class win32_operatingsystem -ComputerName $enterPC).installdate))
    Write-Host "`n" # for creating space
    "User logged In: " + $computerSystem.UserName
    $LastBoot = Get-WmiObject -Class Win32_OperatingSystem –ComputerName $enterPC
if ($LastBoot -ne $null) {
    $lastBootTime = $LastBoot.ConvertToDateTime($LastBoot.LastBootUpTime)
    Write-Host "Last Reboot: $lastBootTime"
}
else {
    Write-Host "Unable to retrieve last boot time."
}

}
