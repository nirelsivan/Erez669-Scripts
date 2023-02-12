Import-Module activedirectory

while ($true) {
    clear
    $userList = Read-Host 'Enter a comma-separated list of users (for example apple,banana,tomato)'
    $userArray = $userList.Split(',')
    $branchNumber = Read-Host 'Enter branch number'
    $groupName = "Branch_$branchNumber"
    $groupDN = "LDAP://CN=$groupName,OU=Branch Groups,OU=Group Objects,OU=OUs,DC=posprod,DC=supersol,DC=co,DC=il"
    $group = [ADSI]$groupDN

    foreach ($user in $userArray) {
        $userDN = (Get-ADUser -Identity $user).DistinguishedName
        $group.Add("LDAP://$userDN")
        Start-Sleep -s 07
    }

    if ($userList -eq 'exit') {
        break
    }
}
