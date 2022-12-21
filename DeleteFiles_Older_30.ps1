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
$excluded = @("killtask.jpg , LogViewer.lnk")
Get-ChildItem * -Recurse -Force -Verbose -Exclude $excluded | Where-Object {($_.LastWriteTime -lt (Get-Date).AddDays(-30)) -and (($_.Type -eq "file"))} | Remove-Item -Exclude $excluded -Force -Verbose
Remove-Item -Exclude $excluded -Force -Verbose | Where-Object {($_.Type -eq "folder")}
