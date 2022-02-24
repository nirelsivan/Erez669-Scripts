$temp = Get-ChildItem c:\retalix\wingpos\Files\Images\CustomerScreen\Backgrounds\* | where {$_.LastWriteTime -ge (Get-Date).AddMonths(-12)} | select name, lastwritetime | export-csv d:\install\$env:COMPUTERNAME.csv
$Date = Get-ChildItem c:\retalix\wingpos\Files\Images\CustomerScreen\Backgrounds\vcd_idle.png | where {$_.LastWriteTime -ge (Get-Date).AddMonths(-12)} | select lastwritetime
if  ( $Date -eq "13/02/2022 15:44:15" ){
exit }
else {Copy-Item "D:\Install\$env:COMPUTERNAME.csv" -Destination "\\ivantiappsrv.corp.supersol.co.il\IvantiShare\Packages\POS\POSLOGO_DateModified" }

exit
