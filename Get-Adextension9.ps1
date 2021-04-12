# ---------------------------------------------------------------------------
#                   This script was written by erez schwartz
# ---------------------------------------------------------------------------

$ErrorActionPreference = 'SilentlyContinue'

while ($true) {
cls
write-host "edit AD extensionAttribute9 IDnumber"
write-host "`n" # for creating space
$Username = Read-Host 'Enter AD UserName' # prompt user to input value
write-host "`n" # for creating space
$IDnumber = (Get-ADUser $Username -Properties extensionAttribute9).extensionAttribute9
$currentID = Read-Host "current IDnumber is $IDnumber do you want to edit? (y/n/r/c) r = remove first 0 / c = Change Existing"

if ($currentID -eq 'c')
{
write-host "`n" # for creating space
$newID = Read-Host 'Enter new ID Number'
Set-ADUser -Identity $Username -replace @{extensionAttribute9 = "$newID"}
$newValue = $newID -replace "^0"
Set-ADUser -identity $Username -replace @{extensionAttribute9=$newValue}
write-host "`n" # for creating space
Write-Output 'Value Changed Successfully'
}

if (($currentID -eq 'y') -and ($null -eq $undefinedVariable))
{
write-host "`n" # for creating space
$newID = Read-Host 'Enter ID Number'
Set-ADUser -Identity $Username -add @{extensionAttribute9 = "$newID"}
$newValue = $newID -replace "^0"
Set-ADUser -identity $Username -replace @{extensionAttribute9=$newValue}
write-host "`n" # for creating space
Write-Output 'Value added to extensionAttribute9'
}

if ($currentID -eq 'r')
{
$newValue = $IDnumber -replace "^0"
Set-ADUser -identity $Username -replace @{extensionAttribute9=$newValue}
write-host "`n" # for creating space
Write-Output 'the first 0 digit was removed Successfully'
}

if ($currentID -eq 'n')
{
write-host "`n" # for creating space
Write-Output 'Value not changed'
}
Start-Sleep -s 05 # delay command
}
