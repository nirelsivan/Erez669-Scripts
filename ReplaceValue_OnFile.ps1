$name = $env:COMPUTERNAME.Substring(4,3)
$path = 'c:\Program Files\Retalix\SCO.NET\App\sco.exe.config'
$replacement = "posnlb$name"
$text = Get-Content $path
$text = $text -replace 'posnlb\d{3}',$replacement #this is a regular expression that find in our case 3 digits after the 'posnlb' value
$text | Set-Content $path