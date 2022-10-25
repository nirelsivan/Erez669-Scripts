$Action = New-ScheduledTaskAction -Execute 'shutdown.exe -r -t 0 -f'
$date = (([DateTime]::Today).AddDays(1)).AddHours(2) # Returns a new DateTime that adds the specified number of hours to the value of this instance.
$Trigger = New-ScheduledTaskTrigger -Once -at $date
$Settings = New-ScheduledTaskSettingsSet
$Task = New-ScheduledTask -Action $Action -Trigger $Trigger -Settings $Settings
Register-ScheduledTask -TaskName 'Reboot' -InputObject $Task -User system
