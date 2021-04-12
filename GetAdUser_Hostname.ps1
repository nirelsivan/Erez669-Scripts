while ($true)
{
cls
write-host "Find AD Hostname by Username"
write-host "`n" # for creating space
$UserName = Read-Host -Prompt 'Enter Destination UserName'
$HostName = get-aduser $UserName -properties Company |select company
write-host "`n" # for creating space
write-output "the hostname for $UserName is $HostName"
Start-Sleep -s 10 # delay command
}