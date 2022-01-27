while ($true) {
cls
Write-Host "Update ADSI SPN Values"
write-host "`n" # for creating space
$spn = Read-Host 'enter snif number'
setspn -d MSSQLSvc/plpossrv$spn posprod\sqlsnif
setspn -d MSSQLSvc/plpossrv$spn.posprod.supersol.co.il posprod\sqlsnif
setspn -d MSSQLSvc/plpossrv$spn.posprod.supersol.co.il:1433 posprod\sqlsnif
setspn -d MSSQLSvc/plpossrv$spn.posprod.supersol.co.il posprod\sql2017
setspn -d MSSQLSvc/plpossrv$spn.posprod.supersol.co.il:1433 posprod\sql2017
setspn -d MSSQLSvc/slpossrv$spn posprod\sqlsnif
setspn -d MSSQLSvc/slpossrv$spn.posprod.supersol.co.il posprod\sqlsnif
setspn -d MSSQLSvc/slpossrv$spn.posprod.supersol.co.il:1433 posprod\sqlsnif
setspn -d MSSQLSvc/slpossrv$spn.posprod.supersol.co.il posprod\sql2017
setspn -d MSSQLSvc/slpossrv$spn.posprod.supersol.co.il:1433 posprod\sql2017
setspn -d MSSQLSvc/wlpossrv$spn posprod\sqlsnif
setspn -d MSSQLSvc/wlpossrv$spn.posprod.supersol.co.il posprod\sqlsnif
setspn -d MSSQLSvc/wlpossrv$spn.posprod.supersol.co.il:1433 posprod\sqlsnif
setspn -d MSSQLSvc/wlpossrv$spn.posprod.supersol.co.il posprod\sql2017
setspn -d MSSQLSvc/wlpossrv$spn.posprod.supersol.co.il:1433 posprod\sql2017
setspn -s MSSQLSvc/plpossrv$spn posprod\sql2017
setspn -s MSSQLSvc/plpossrv$spn.posprod.supersol.co.il posprod\sql2017
setspn -s MSSQLSvc/plpossrv$spn.posprod.supersol.co.il:1433 posprod\sql2017
setspn -s MSSQLSvc/slpossrv$spn posprod\sql2017
setspn -s MSSQLSvc/slpossrv$spn.posprod.supersol.co.il posprod\sql2017
setspn -s MSSQLSvc/slpossrv$spn.posprod.supersol.co.il:1433 posprod\sql2017
setspn -s MSSQLSvc/wlpossrv$spn posprod\sql2017
setspn -s MSSQLSvc/wlpossrv$spn.posprod.supersol.co.il posprod\sql2017
setspn -s MSSQLSvc/Wlpossrv$spn.posprod.supersol.co.il:1433 posprod\sql2017
}
