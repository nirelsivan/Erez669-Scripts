$computername = $env:COMPUTERNAME
$name = ($computername -split '-')[1]
$paths = @('c:\retalix\wingpos\GroceryWinPos.exe.config', 'c:\program files\Retalix\SCO.NET\App\sco.exe.config', 'c:\Program Files (x86)\Retalix\SCO.NET\App\sco.exe.config')
$value = 'posnlb'
$replacement = "$value$name"

foreach ($path in $paths) {
    if (Test-Path $path) {
        $text = [System.IO.File]::ReadAllText($path)

        if ($text -match 'plpossrv') {
            $text = $text -replace '<URL>http://plpossrv(.*?).posprod.supersol.co.il:4444/wsgpos/Service.asmx</URL>', "<URL>http://plpossrv$name.posprod.supersol.co.il:4444/wsgpos/Service.asmx</URL>"
        } else {
            $text = $text -replace '<URL>http://posnlb(.*?).posprod.supersol.co.il:4444/wsgpos/Service.asmx</URL>', "<URL>http://$replacement.posprod.supersol.co.il:4444/wsgpos/Service.asmx</URL>"
        }

        [System.IO.File]::WriteAllText($path, $text)
    }
}
