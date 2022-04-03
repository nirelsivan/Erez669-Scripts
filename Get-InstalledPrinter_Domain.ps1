# ---------------------------------------------------------------------------
#                   This script was written by erez schwartz
# ---------------------------------------------------------------------------

$ErrorActionPreference = 'SilentlyContinue'

while ($true) {
cls
write-host "Getting Printer Information from Remote Machine"
write-host "`n" # for creating space
$Computer = Read-host 'Enter Hostname or IP Address'
$UserName = read-host 'Enter desired User'
$domain = Get-Credential mydomain\***adm

# ---------------------------------------------------------------------------
#   Part 1: Enable Remote Registry Service
# ---------------------------------------------------------------------------

$Service = "RemoteRegistry"
$RemoteRegistry = Get-CimInstance -Class Win32_Service -ComputerName $Computer -Filter 'Name = "$Service"'
Set-Service -Name $Service -ComputerName $Computer -StartupType Automatic
Start-Service -InputObject (Get-Service -Name $Service -ComputerName $Computer)

# ---------------------------------------------------------------------------
#   Part 2: find the network printers and default printer on remote pc
# ---------------------------------------------------------------------------

write-host "`n"
Write-Output "local printers of $UserName is"
write-host "`n"
gwmi Win32_Printer -computer $Computer -Credential $domain
$UserSID = ((New-Object System.Security.Principal.NTAccount($UserName)).Translate([System.Security.Principal.SecurityIdentifier])).Value #(translate username to usersid)

write-host "`n"
Write-Output "network printers of $UserName is"
reg query \\$Computer\HKEY_USERS\$UserSID\Printers\Connections

# ---------------------------------------------------------------------------
#   if printer configured not from printer server, then show IP address
# ---------------------------------------------------------------------------

write-host "`n"
Write-Output "the default printer of $UserName is"
reg query "\\$Computer\HKEY_USERS\$UserSID\SOFTWARE\Microsoft\Windows NT\CurrentVersion\Windows" /v device #(default printer)

write-host "`n"
Write-Output "IP address of Printers that Configured directly on the machine is"
reg query "\\$Computer\HKEY_LOCAL_MACHINE\SYSTEM\CurrentControlSet\Control\Print\Monitors\Standard TCP/IP Port\Ports"

$exit = Read-Host 'do you want to exit (y\n)'
if ($exit -eq 'y'){
break;
else
$while
}
}
