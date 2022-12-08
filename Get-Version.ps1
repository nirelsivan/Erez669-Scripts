clear
$servers = get-content c:\temp\PC.txt
$file = 'c:\temp\test.csv'

foreach ($server in $servers)
{
write-host "Files on '$server':" -foregroundcolor yellow -Verbose
invoke-command -computername $server {(get-childitem -path "c:\psoftw\piryon2.exe" -Recurse -Verbose).VersionInfo
} | select -Property PSComputerName , FileVersion | Export-Csv -Path $file -Append -Verbose -Force -Encoding UTF8 -NoTypeInformation
}