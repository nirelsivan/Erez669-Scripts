$computerlist = get-content -path "\\10.251.10.251\supergsrv\HdMatte\PowerShell\Computers.txt"
foreach ($computer in $computerlist) {
$newou = "OU=Test,OU=MarlogRishon,OU=Workstations,DC=corp,DC=supersol,DC=co,DC=il"
Get-ADComputer $computer |Move-ADObject -TargetPath $newou -Verbose # check the current AD object OU and moving it to the requested OU
}
Write-Host "operation completed successfully"