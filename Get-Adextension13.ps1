# ---------------------------------------------------------------------------
#                   This script was written by erez schwartz
# ---------------------------------------------------------------------------

$ErrorActionPreference = 'SilentlyContinue'

while ($true) {
cls
write-host "edit AD extensionAttribute13 Information"
write-host "`n" # for creating space
$Username = Read-Host 'Enter AD UserName' # prompt user to input value
write-host "`n" # for creating space
$Info = (Get-ADUser $Username -Properties extensionAttribute13).extensionAttribute13
$currentID = Read-Host "current Information is $Info ,do you want to change it? (y/n/c) / c = Change Existing"

if ($currentID -eq 'n')
{
write-host "`n" # for creating space
Write-Output 'Value not changed'
}

if ($currentID -eq 'c')
{
write-host "`n" # for creating space
$newtext = Read-Host 'Enter new Text'
Set-ADUser -Identity $Username -replace @{extensionAttribute13 = "$newtext"}
write-host "`n" # for creating space
Write-Output 'Value Changed Successfully'
}

if (($currentID -eq 'y') -and ($null -eq $undefinedVariable))
{
write-host "`n" # for creating space
$newtext = Read-Host 'Enter new Text'
Set-ADUser -Identity $Username -add @{extensionAttribute13 = "$newtext"}
write-host "`n" # for creating space
Write-Output 'Value added to extensionAttribute13'
}
Start-Sleep -s 05 # delay command
}