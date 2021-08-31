param([switch]$Elevated)

function Test-Admin {
    $currentUser = New-Object Security.Principal.WindowsPrincipal $([Security.Principal.WindowsIdentity]::GetCurrent())
    $currentUser.IsInRole([Security.Principal.WindowsBuiltinRole]::Administrator)
}

if ((Test-Admin) -eq $false)  {
    if ($elevated) {
        # tried to elevate, did not work, aborting
    } else {
        Start-Process powershell.exe -Verb RunAs -ArgumentList ('-noprofile -file "{0}" -elevated' -f ($myinvocation.MyCommand.Definition))
    }
    exit
}

$CN = $env:COMPUTERNAME
$root = [ADSI]''
$searcher = New-Object System.DirectoryServices.DirectorySearcher($root)
$searcher.filter = "(&(objectclass=computer)(cn= $CN))"
$name = $searcher.findall() 

# Get the DN of the object
$computerDN = $name.Properties.Item("DistinguishedName")

# Connect to the computer object
$Object = [ADSI]"LDAP://$ComputerDN"

# Specify the target OU
$TargetOU = "OU=Test,OU=MarlogRishon,OU=Workstations,DC=corp,DC=supersol,DC=co,DC=il"
$TargetOU="LDAP://$TargetOU"

# Move the object to the target OU
$Object.psbase.MoveTo($TargetOU)
