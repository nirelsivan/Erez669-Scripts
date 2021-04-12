write-output "Enable Remote Registry Service"
write-host "`n" # for creating space
$Computer = read-host -prompt "Enter Hostname\IP Address"
$Service = "RemoteRegistry"
$RemoteRegistry = Get-CimInstance -Class Win32_Service -ComputerName $Computer -Filter 'Name = "$Service"'
Set-Service -Name $Service -ComputerName $Computer -StartupType Automatic
Start-Service -InputObject (Get-Service -Name $Service -ComputerName $Computer)
write-host "`n" # for creating space
Write-Output "$Computer : Remote Registry has been Enabled and Running"
timeout /t 7