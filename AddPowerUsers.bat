@echo off
pushd "%~dp0"
powershell.exe -Command "Start-Process powershell \"Set-Itemproperty -path HKLM:\SOFTWARE\Policies\Microsoft\Windows\PowerShell -name ExecutionPolicy -value ByPass"" -Verb RunAs"
powershell.exe -Command "Start-Process 'powershell' -Verb RunAs -ArgumentList '/c "powershell.exe -NoProfile -ExecutionPolicy Bypass -File "%~dp0AddPowerUsers.ps1"'"
powershell.exe -Command "Start-Process powershell \"Set-Itemproperty -path HKLM:\SOFTWARE\Policies\Microsoft\Windows\PowerShell -name ExecutionPolicy -value RemoteSigned"" -Verb RunAs"
popd
exit /b 0