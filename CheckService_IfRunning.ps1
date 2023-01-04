If (-NOT ([Security.Principal.WindowsPrincipal][Security.Principal.WindowsIdentity]::GetCurrent()).IsInRole([Security.Principal.WindowsBuiltInRole] "Administrator"))
{  
    $arguments = "& '" + $myinvocation.mycommand.definition + "'"
    Start-Process powershell -Verb runAs -ArgumentList $arguments
    Break
}

$services = Get-Service | Where-Object {$_.Name -like "HD*" -and $_.Status -eq "Stopped"}

foreach ($service in $services) {
    Start-Service -InputObject $service -Verbose
    Start-Sleep 06
}
