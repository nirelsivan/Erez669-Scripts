If (-NOT ([Security.Principal.WindowsPrincipal][Security.Principal.WindowsIdentity]::GetCurrent()).IsInRole([Security.Principal.WindowsBuiltInRole] "Administrator"))

{   
$arguments = "& '" + $myinvocation.mycommand.definition + "'"
Start-Process powershell -Verb runAs -ArgumentList $arguments
Break
}

clear

Set-Location D:\

$Folder = "D:\"
$excluded = @("killtask.jpg , LogViewer.lnk")

#Delete files older than 1 month
Get-ChildItem $Folder -Recurse -Force -ea 0 |
? {!$_.PsIsContainer -and $_.LastWriteTime -lt (Get-Date).AddDays(-30)} |
ForEach-Object {
   $_ | del -Exclude $excluded -Recurse -Force -Verbose
   $_.FullName | Out-File C:\Temp\deletedlog.txt -Append
}

#Delete empty folders and subfolders
Get-ChildItem $Folder -Recurse -Force -ea 0 |
? {$_.PsIsContainer -eq $True} |
? {$_.getfiles().count -eq 0} |
ForEach-Object {
    $_ | del -Force -Recurse -Verbose
    $_.FullName | Out-File C:\Temp\deletedlog.txt -Append
}
