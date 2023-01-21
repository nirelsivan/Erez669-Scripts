$computername = $env:COMPUTERNAME
$name = ($computername -split '-')[1]
#on newer powershell version we will use the substring for computername split, for example $env:COMPUTERNAME.substring(4,3)
$path = 'c:\Program Files (x86)\Retalix\SCO.NET\App\sco.exe.config'
$value = 'posnlb'
$replacement = "$value$name"
$text = [System.IO.File]::ReadAllText($path)

if ($text -match 'plpossrv') {
$text = $text -replace '<URL>http://plpossrv(.*?).posprod.supersol.co.il:4444/wsgpos/Service.asmx</URL>', "<URL>http://plpossrv$name.posprod.supersol.co.il:4444/wsgpos/Service.asmx</URL>"
} else {
$text = $text -replace '<URL>http://posnlb(.*?).posprod.supersol.co.il:4444/wsgpos/Service.asmx</URL>', "<URL>http://$replacement.posprod.supersol.co.il:4444/wsgpos/Service.asmx</URL>"
}

[System.IO.File]::WriteAllText($path, $text)
