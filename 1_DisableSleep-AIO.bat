@echo off
echo Disabling all Sleep Parameters
pushd "%~dp0"
reg add "HKLM\SOFTWARE\Policies\Microsoft\Windows\CurrentVersion\Internet Settings\ZoneMap" /f /v UNCAsIntranet /t REG_DWORD /d 1 > nul 2>&1
reg add "HKLM\SOFTWARE\Policies\Microsoft\Windows\WindowsUpdate\AU" /f /v AllowMUUpdateService /t REG_DWORD /d 1 > nul 2>&1
reg add "HKLM\SOFTWARE\Policies\Microsoft\Windows\PowerShell" /v ExecutionPolicy /t REG_SZ /d ByPass /f > nul 2>&1
taskkill /f /im "SecurityHealthSystray.exe" /t
reg delete "HKLM\SOFTWARE\Microsoft\Windows\CurrentVersion\Run" /v securityhealth /f /reg:32 > nul 2>&1
reg delete "HKLM\SOFTWARE\Microsoft\Windows\CurrentVersion\Run" /v securityhealth /f /reg:64 > nul 2>&1
regedit /s "RegisteredOwner.reg"
regedit /s "Scripts.reg"
powershell.exe -executionpolicy bypass -file "%~dp0TrustedLocation.ps1"
call SecureWarning_Fix_CurrentUser.bat
call EnableConfirmDialogAllUsers.bat
powershell.exe Set-NetFirewallProfile -Profile Domain,Public,Private -Enabled False
regedit /s "Policy.reg"
powercfg /s 8c5e7fda-e8bf-4a96-9a85-a6e23a8c635c
powercfg /x -hibernate-timeout-ac 0
powercfg /x -hibernate-timeout-dc 0
powercfg /x -disk-timeout-ac 0
powercfg /x -disk-timeout-dc 0
powercfg /x -monitor-timeout-ac 15
powercfg /x -monitor-timeout-dc 15
Powercfg /x -standby-timeout-ac 0
powercfg /x -standby-timeout-dc 0
powercfg /h off
ping -n 4 127.0.0.1
reg add "HKLM\SOFTWARE\Policies\Microsoft\Windows\PowerShell" /v ExecutionPolicy /t REG_SZ /d ByPass /f > nul 2>&1
powershell.exe -executionpolicy bypass -file "%~dp0RealtekSleep.ps1"
reg add "HKLM\SOFTWARE\Policies\Microsoft\Windows\PowerShell" /v ExecutionPolicy /t REG_SZ /d ByPass /f > nul 2>&1
powershell.exe -executionpolicy bypass -file "%~dp0IntelSleep.ps1"
regedit /s "Default.reg"
regedit /s "Scripts.reg"
regedit /s "WSUS-Policy.reg"
regedit /s "EnableRegBackup.reg"
regedit /s "WinUpdates.reg"
schtasks /run /i /tn "\Microsoft\Windows\Registry\RegIdleBackup"
reg add "HKLM\Software\Microsoft\Windows\CurrentVersion\RunOnce" /v EnableRegBackup /t REG_SZ /d "schtasks /run /i /tn ""\Microsoft\Windows\Registry\RegIdleBackup""" /f > nul 2>&1
REG ADD "HKLM\SOFTWARE\Policies\Microsoft\Windows\WindowsUpdate\AU" /f /v AllowMUUpdateService /t REG_DWORD /d 1 > nul 2>&1
REG ADD "HKLM\SOFTWARE\Policies\Microsoft\Windows\DeliveryOptimization" /f /v DODownloadMode /t REG_DWORD /d 3 > nul 2>&1
schtasks /Change /Disable /Tn "Microsoft\Windows\Defrag\ScheduledDefrag"
call DefaultLanguageFix.bat
popd
gpupdate /force
echo process finished, press any key to reboot.
pause > nul
shutdown -r -t 0