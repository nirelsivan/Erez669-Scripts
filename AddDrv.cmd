@echo off
Echo adding drivers to Image
call c:\ps\cert\RunCert.bat
Echo adding drivers to Image
if not exist c:\drivers goto :end
FOR /F "usebackq delims=" %%i IN (`dir c:\drivers\* /S /B`) do (
  if /I "%%~xi" == ".inf" (
    echo adding driver %%i
    echo adding driver %%i >> c:\AddDrv.txt
    pnputil -i -a %%i >> c:\AddDrv.txt
  )
)
netsh advfirewall set allprofiles state off
rem ***Add Schedule Task To Remove Welcome Screen Popup - AutoLogon***
rem schtasks.exe /create /tn "ClearPolicy" /ru SYSTEM /Sc ONSTART /tr "C:\ps\ClearPolicy.cmd"


:end
exit /b 0