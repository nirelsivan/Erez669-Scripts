$ErrorActionPreference = 'SilentlyContinue'
Get-ScheduledTask -TaskName "Reboot" -TaskPath \
Unregister-ScheduledTask -TaskName "Reboot" -TaskPath \ -Confirm:$false
$Action = New-ScheduledTaskAction -Execute 'shutdown.exe' -Argument '-r -t 0 -f'
$Trigger = New-ScheduledTaskTrigger -Weekly -At "12/16/2022 11pm" -DaysOfWeek Friday
$Settings = New-ScheduledTaskSettingsSet -Hidden -StartWhenAvailable -AllowStartIfOnBatteries -DontStopIfGoingOnBatteries -WakeToRun -ExecutionTimeLimit 0 -Verbose
New-ScheduledTask -Action $Action -Trigger $Trigger -Settings $Settings -Verbose
Register-ScheduledTask -TaskName 'Reboot' -Action $Action -Settings $settings -Trigger $Trigger -RunLevel Highest -User system
