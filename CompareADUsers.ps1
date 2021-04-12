
################### 
# CompareADUsers.ps1
# Version 0.1 
# Changelog : n/a 
# Erez Schwartz - 02.04.2020 
################### 


<#
 	.SYNOPSIS
        Script to compare two Active Directory users and output only the difference in group membership.

    .DESCRIPTION
        This script compares two AD users group membership and displays only the difference in membership. 
        Only the name of the group will be displayed and will be sorted alphabetically. The SideIndicator 
        indicates which AD user was found in the corresponding AD group. A SideIndicator of <= indicates
        the first AD user is a member. A SideIndicator of => indicates the second AD user is a member. 
        Groups that both users are a part of will not be displayed. 

    .EXAMPLE
        PS C:\>CompareADUsers.ps1
#>

# Enter First AD User
$user1 = Read-Host "Enter the identity of the first AD User"

# Get AD group membership of User1
$member1 = Get-ADPrincipalGroupMembership -Identity $user1

# Enter Second AD User
$user2 = Read-Host "Enter the identity of the second AD User"

# Get AD group membership of User2
$member2 = Get-ADPrincipalGroupMembership -Identity $user2

# Output Message
Write-Host
"$user1 and $user2 have the following difference in AD group membership.
The SideIndicator indicates which AD user was found in the corresponding AD group. 
$user1 is a member of SideIndicator <= and $user2 is a member of SideIndicator =>
Groups that both users are a part of are not displayed.
"

# Compare user1 membership to user2 membership and display only the difference in membership. Only show the name of the group and sort alphabetically.
# The SideIndicator indicates which AD user was found in the corresponding AD group.
Compare-Object -ReferenceObject ($member1) -DifferenceObject ($member2) -Property Name | Sort Name