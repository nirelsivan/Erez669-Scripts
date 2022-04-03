$temp = Get-ChildItem c:\Backgrounds\* | where {$_.LastWriteTime -ge (Get-Date).AddMonths(-12)} | select name, lastwritetime | export-csv d:\install\$env:COMPUTERNAME.csv
$Date = Get-ChildItem c:\Backgrounds\vcd_idle.png | where {$_.LastWriteTime -ge (Get-Date).AddMonths(-12)} | select lastwritetime
if  ( $Date -eq "13/02/2022 15:44:15" ){
exit }
else {Copy-Item "D:\Install\$env:COMPUTERNAME.csv" -Destination "\\myserver\LOGO_DateModified" }

exit
