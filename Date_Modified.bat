SET Snif=%computername:~0,10%
SET filename="c:\retalix\wingpos\Files\Images\CustomerScreen\Backgrounds\vcd_idle.png"
FOR %%f IN (%filename%) DO SET filedatetime=%%~tf
IF "%filedatetime:~0,-3%" == "13/02/2022 15:44" GOTO END
echo "%filedatetime:~0,-3%" >d:\install\%Snif%.csv 
xcopy "d:\install\%Snif%.csv" "\\ivantiappsrv.corp.supersol.co.il\IvantiShare\Packages\POS\POSLOGO_DateModified"
:END
exit /b 0
