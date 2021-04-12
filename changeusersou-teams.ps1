										# written by Erez Schwartz
										
Set-Itemproperty -path HKLM:\SOFTWARE\Policies\Microsoft\Windows\PowerShell -name ExecutionPolicy -value ByPass

$ErrorActionPreference = 'SilentlyContinue'

while ($true){
cls
Write-Host "Set Permissions for Microsoft Teams" # show message on the screen
write-host "`n" # for creating space
$Username = Read-Host 'Enter AD User' # prompt user to input value
$cred = Get-Credential supersol\***adm
$newou = "OU=Users-Office365,DC=corp,DC=supersol,DC=co,DC=il"
Set-ADUser -Identity $Username -Replace @{userPrincipalName="$Username@mydomain.com"} # change upn suffix
$Groups = @("Office365_Lic_Default","Office365_Lic_Teams_Online","Office365 Required MFA")
ForEach ($Group in $Groups) {Add-ADPrincipalGroupMembership $Username -MemberOf $Group} # add requested groups to the user
Get-ADUser $Username | Move-ADObject -targetpath $newou # check the current AD object OU and moving it to the requested OU
write-host "`n" # for creating space
Write-Output "operation complete, please check AD for verify"
Start-Sleep -s 05 # delay command
}
