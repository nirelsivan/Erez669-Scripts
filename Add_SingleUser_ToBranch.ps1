Import-Module activedirectory
$user = Read-Host 'enter username to add branch group'
$branchNumber = Read-Host 'enter branch number'
$groupName = "Branch_$branchNumber"
$groupDN = "LDAP://CN=$groupName,OU=Branch Groups,OU=Group Objects,OU=OUs,DC=posprod,DC=supersol,DC=co,DC=il"
$group = [ADSI]$groupDN
$userDN = (Get-ADUser -Identity $user).DistinguishedName
$group.Add("LDAP://$userDN")