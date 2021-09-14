while ($true) {
cls
write-host "Restart Landesk Remote Service for bypass Remote Control bug"
write-host "`n" # for creating space
$ComputerName = Read-Host "Enter PC Name"
write-host "`n" # for creating space
$Service = Get-Service -ComputerName $ComputerName | Where {$_.DisplayName -like "*landesk remote*"}
echo $Service
Restart-Service -InputObject $Service
write-host "`n" # for creating space
echo $Service
Start-Sleep -s 05
}