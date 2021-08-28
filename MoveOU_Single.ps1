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

# Retrieve DN of local computer.
$env:COMPUTERNAME
$SysInfo = New-Object -ComObject "ADSystemInfo"
$ComputerDN = $SysInfo.GetType().InvokeMember("ComputerName", "GetProperty", $Null, $SysInfo, $Null)

# Bind to computer object in AD.
$Computer = [ADSI]"LDAP://$ComputerDN"

# Specify target OU.
$TargetOU = "OU=Test,OU=MarlogRishon,OU=Workstations,DC=corp,DC=supersol,DC=co,DC=il"

# Bind to target OU.
$OU = [ADSI]"LDAP://$TargetOU"

# Move computer to target OU.
$Computer.psbase.MoveTo($OU)