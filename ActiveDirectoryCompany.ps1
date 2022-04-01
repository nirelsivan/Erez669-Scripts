write-output "Add Computername to Active Directory Company and Remote Desktop Users Group"
write-host "`n" # for creating space
$UserName = Read-Host -Prompt 'Enter Destination UserName'
$Computer = Read-Host -Prompt 'Enter Hostname\IP Address'
$LocalGroup = "Remote Desktop Users"
$AdminGroup = "Administrators"
$Domain = "mydomain"
$DomainCredential = Get-Credential "supersol\***adm"
Set-ADUser -Identity $UserName -company $Computer -Credential $DomainCredential
([ADSI]"WinNT://$Computer/$AdminGroup,group").psbase.Invoke("Add",([ADSI]"WinNT://$Domain/$UserName").path)
([ADSI]"WinNT://$Computer/$LocalGroup,group").psbase.Invoke("Add",([ADSI]"WinNT://$Domain/$UserName").path)
write-host "`n" # for creating space
write-output "Operation Complete"
timeout /t 5
