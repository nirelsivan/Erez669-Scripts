$computerName = (Get-WmiObject -Class Win32_ComputerSystem).Name
$branchNumber = ($computerName -split '-')[1]
$groupName = "Branch_$branchNumber"
$groupDN = "LDAP://CN=$groupName,OU=Branch Groups,OU=Group Objects,OU=OUs,DC=posprod,DC=supersol,DC=co,DC=il"
$group = New-Object System.DirectoryServices.DirectoryEntry($groupDN)
$computerDN = "LDAP://CN=$computerName,OU=USB Restricted,OU=Cachiers,OU=Branches,OU=OUs,DC=posprod,DC=supersol,DC=co,DC=il"
$computer = New-Object System.DirectoryServices.DirectoryEntry($computerDN)
$group.Invoke("Add", $computer.Path)
