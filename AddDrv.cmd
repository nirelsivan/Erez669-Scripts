@echo off
Echo adding drivers to Image
if not exist c:\drivers goto :end
FOR /F "usebackq delims=" %%i IN (`dir c:\drivers\* /S /B`) do (
  if /I "%%~xi" == ".inf" (
    echo adding driver %%i
    echo adding driver %%i >> c:\AddDrv.txt
    pnputil -i -a %%i >> c:\AddDrv.txt
  )
)

:end
exit /b 0
