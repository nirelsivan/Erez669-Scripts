										# written by Erez Schwartz
Set-Itemproperty -path HKLM:\SOFTWARE\Policies\Microsoft\Windows\PowerShell -name ExecutionPolicy -value ByPass # for shufersal network security

cls
Write-Host "Set Permissions for Microsoft Teams, get userlist from .txt file" # show message on the screen
write-host "`n" # for creating space
$cred = Get-Credential supersol\***adm
$UserNames = get-content -path "\\10.251.10.251\supergsrv\HdMatte\PowerShell\TeamsUsers.txt"
foreach ($user in $UserNames) {
$newou = "OU=Users-Office365,DC=corp,DC=supersol,DC=co,DC=il"
Set-ADUser $user -Replace @{userPrincipalName="$user@shufersal.co.il"} # change upn suffix
$Groups = @("Office365_Lic_Default","Office365_Lic_Teams_Online","Office365 Required MFA")
ForEach ($Group in $Groups) {Add-ADPrincipalGroupMembership $user -MemberOf $Group} # add requested groups to the user
Get-ADUser $user | Move-ADObject -targetpath $newou # check the current AD object OU and moving it to the requested OU
}
write-host "`n" # for creating space
Write-Output "operation complete, please check AD for verify"
Start-Sleep -s 05 # delay command