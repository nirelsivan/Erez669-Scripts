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

while ($true) {
cls
write-output "Add LocalAdmin"
write-host "`n" # for creating space
$UserName = Read-Host -Prompt 'Enter Destination UserName'
$Computer = Read-Host -Prompt 'Enter Hostname\IP Address'
$AdminGroup = "Administrators"
$Domain = "mydomain"
$DomainCredential = Get-Credential "mydomain\***adm"
([ADSI]"WinNT://$Computer/$AdminGroup,group").psbase.Invoke("Add",([ADSI]"WinNT://$Domain/$UserName").path)
write-host "`n" # for creating space
write-output "Operation Complete, wait for logout"
$sessionId = ((quser /server:$Computer | Where-Object { $_ -match $UserName }) -split ' +')[2]
$sessionId
logoff $sessionId /server:$Computer
timeout /t 5
}
$while
