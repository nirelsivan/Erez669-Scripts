If (-NOT ([Security.Principal.WindowsPrincipal][Security.Principal.WindowsIdentity]::GetCurrent()).IsInRole([Security.Principal.WindowsBuiltInRole] "Administrator"))

{   
$arguments = "& '" + $myinvocation.mycommand.definition + "'"
Start-Process powershell -Verb runAs -ArgumentList $arguments
Break
}

<# you must enable LongPath DWORD in registry on path

"HKEY_LOCAL_MACHINE\SYSTEM\CurrentControlSet\Control\FileSystem" in order to use this script #>

clear

Set-Location d:\
$Daysback = "-30"
$CurrentDate = Get-Date
$excluded = @("killtask.jpg , LogViewer.lnk")
$DatetoDelete = $CurrentDate.AddDays($Daysback)
Get-ChildItem * -Recurse -Exclude $excluded -Verbose | Where-Object { "$_.LastWriteTime -lt $DatetoDelete" } | Remove-Item -Verbose -Recurse -Force -Exclude $excluded
Remove-Item -LiteralPath d:\ -Verbose -Recurse -Force -Exclude $excluded | Where-Object { "$_.LastWriteTime -lt $DatetoDelete" }
