$name = $env:COMPUTERNAME.Substring(4,3)
$path = 'c:\Program Files (x86)\Retalix\SCO.NET\App\sco.exe.config'
$replacement = "$value$name"
$text = Get-Content $path
$text = $text -replace '<URL>http://posnlb(.*?).posprod.supersol.co.il:4444/wsgpos/Service.asmx</URL>', "<URL>http://$replacement.posprod.supersol.co.il:4444/wsgpos/Service.asmx</URL>"
$text | Set-Content $path
