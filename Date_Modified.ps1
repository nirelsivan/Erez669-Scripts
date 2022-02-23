#Elevate Credentials
param([switch]$Elevated)
function Check-Admin {
$currentUser = New-Object Security.Principal.WindowsPrincipal `
$([Security.Principal.WindowsIdentity]::GetCurrent())
$currentUser.IsInRole([Security.Principal.WindowsBuiltinRole]::Administrator) }
if ((Check-Admin) -eq $false) {
    if ($elevated){
} else {
    Start-Process powershell.exe -Verb RunAs -ArgumentList `
 ('-noprofile -noexit -file "{0}" -elevated' -f ( $myinvocation.MyCommand.Definition ))
    } exit
}
#Start Main Script

<# 

$temp =@() --> Collection Variable, it's a composite variable whose internal components, 
called elements, have the same data type. The value of a collection variable and the values of its elements can change.
$temp += $OtherVariable
means that we want to take our current collection and add one more object into it #>

Enable-PSRemoting -Force
$temp = @()
$computers = Get-Content -Path "c:\temp\comp.txt"
foreach ($computer in $computers) {
$temp += invoke-command -computername $computer -scriptblock {
Get-ChildItem C:\temp\* | where {$_.LastWriteTime -ge (Get-Date).AddMonths(-12)} | select name, lastwritetime
}
}
$temp | export-csv c:\temp\check.csv