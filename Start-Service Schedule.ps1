If (-NOT ([Security.Principal.WindowsPrincipal][Security.Principal.WindowsIdentity]::GetCurrent()).IsInRole([Security.Principal.WindowsBuiltInRole] "Administrator"))

{   
$arguments = "& '" + $myinvocation.mycommand.definition + "'"
Start-Process powershell -Verb runAs -ArgumentList $arguments
Break
}

$serviceName = @("LANDesk(R) PXE Service","LANDesk(R) PXE MTFTP Service")
$service = Get-Service -Name $serviceName | Where-Object {$_.Status -ne 'Running'} | start-service
Start-Sleep 05
