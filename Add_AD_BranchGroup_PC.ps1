$ErrorActionPreference = 'SilentlyContinue'
Import-Module activedirectory

Get-Content .\Computers.txt | ForEach-Object {
    $computerName = $_.Trim()
    $branchNumber = ($computerName -split '-')[1]
    $groupName = "Branch_$branchNumber"
    $groupDN = "LDAP://CN=$groupName,OU=Branch Groups,OU=Group Objects,OU=OUs,DC=posprod,DC=supersol,DC=co,DC=il"
    $group = [ADSI]$groupDN
    $computerDN = "LDAP://CN=$computerName,OU=USB Restricted,OU=Cachiers,OU=Branches,OU=OUs,DC=posprod,DC=supersol,DC=co,DC=il"
    $computer = [ADSI]$computerDN
    $group.Add($computerDN)
}