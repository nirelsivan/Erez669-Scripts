Clear-Host
write-host "`n" # for creating space
Write-Host 'written by Eitan Talmi & Modified by Erez Schwartz'
write-host "`n" # for creating space

$DL_Group = Read-Host -Prompt 'Type the email address of the group you want to get member list'
$group_name = ($DL_Group -split '@')[0]
$Save_To = "C:\Temp\$($group_name)_Members.txt"

# Define a function to recursively retrieve members of a group
function recurse_members($member) {
    Write-Host "recurse_members: $($member.cn)"
    if ($member.objectClass -eq "group") {
        # If it's a group, read the group members
        $members = Get_LDAP_Objects "(&(objectClass=group)(distinguishedName=$($member.distinguishedName)))" "member"
        Write-Host "recurse_members: $($members.Count) member(s)"
        $member_list = @()
        foreach ($sub_member in $members) {
            $DL_Out = recurse_members $sub_member
            if ($DL_Out) {
                Write-Host "recurse_members: $DL_Out"
                $member_list += $DL_Out
            }
        }
        return $member_list
    } else {
        # Sending back the users list to the main
        $Members = $member.cn + " (" + $member.mail + ")"
        Write-Host "recurse_members: $Members"
        return $Members
    }
}

# Define a function to execute an LDAP query and return the results as an array of objects
function Get_LDAP_Objects($filter, $properties) {
    $searcher = New-Object DirectoryServices.DirectorySearcher
    $searcher.SearchScope = "subtree"
    $searcher.PageSize = 1000
    $searcher.Filter = $filter
    foreach ($property in $properties) {
        $searcher.PropertiesToLoad.Add($property) | Out-Null
    }
    try {
        $results = $searcher.FindAll()
    } catch {
        Write-Error "Error executing LDAP query: $_"
        return @()
    }
    $objects = @()
    foreach ($result in $results) {
        $obj = New-Object PSObject
        foreach ($property in $properties) {
            if ($result.Properties.Contains($property)) {
                $obj | Add-Member -NotePropertyName $property -NotePropertyValue $result.Properties[$property][0]
            }
        }
        $objects += $obj
    }
    return $objects
}

# Read the group members 
$group = Get_LDAP_Objects "(&(objectClass=group)(mail=$($DL_Group)))" "distinguishedName"
if ($group.Count -eq 0) {
    Write-Error "Distribution group not found: $DL_Group"
    exit
}
"`r`n$($group[0].cn)`r`n============="
$group_members = Get_LDAP_Objects "(&(objectClass=user)(memberOf=$($group[0].distinguishedName)))" "cn", "mail"
if ($group_members.Count -eq 0) {
    Write-Error "Distribution group has no members: $DL_Group"
    exit
}
$member_list = @()
foreach ($member in $group_members) {
    $Members = $member.cn + " (" + $member.mail + ")"
    Write-Host $Members
    $member_list += $Members
}
$member_list | Sort-Object | Get-Unique | Write-Output | Out-File $Save_To
