while ($true)
{
cls
write-host "Show RAM Information for Local and Remote Machines"
write-host "`n" # for creating space
$Computername = read-host -prompt "Enter Hostname\IP Address"
$PysicalMemory = Get-WmiObject -class "win32_physicalmemory" -namespace "root\CIMV2" -ComputerName $Computername

Write-Host "Memore Modules:" -ForegroundColor Green
$PysicalMemory | Format-Table Tag,BankLabel,@{n="Capacity(GB)";e={$_.Capacity/1GB}},Manufacturer,PartNumber,Speed -AutoSize

Write-Host "Total Memory:" -ForegroundColor Green
Write-Host "$((($PysicalMemory).Capacity | Measure-Object -Sum).Sum/1GB)GB"

$TotalSlots = ((Get-WmiObject -Class "win32_PhysicalMemoryArray" -namespace "root\CIMV2" -ComputerName $Computername).MemoryDevices | Measure-Object -Sum).Sum
Write-Host "`nTotal Memory Slots:" -ForegroundColor Green
Write-Host $TotalSlots

$UsedSlots = (($PysicalMemory) | Measure-Object).Count 
Write-Host "`nUsed Memory Slots:" -ForegroundColor Green
Write-Host $UsedSlots

If($UsedSlots -eq $TotalSlots)
{
    Write-Host "All memory slots are filled up, none is empty!" -ForegroundColor Yellow
}
write-host "`n" # for creating space
pause
}