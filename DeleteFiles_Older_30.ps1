<# you must enable LongPath DWORD in registry on path

"HKEY_LOCAL_MACHINE\SYSTEM\CurrentControlSet\Control\FileSystem" in order to use this script #>

clear

Get-ChildItem -Path d:\ -Recurse -Verbose | Where-Object { $_.LastWriteTime -lt (Get-Date).AddDays(-30) -and $_.Name -notmatch 'killtask.jpg|LogViewer.lnk'} | Remove-Item -Recurse -Force -Verbose

# Delete empty folders and subfolders
    $Folder = "D:\" # Specify the root folder
    gci $Folder -Directory -Recurse -Verbose `
        | Sort-Object { $_.FullName.Length } -Descending `
        | ? { $_.GetFiles().Count -eq 0 } `
        | % {
            if ($_.GetDirectories().Count -eq 0) { 
                Write-Host " Removing $($_.FullName) "
                $_.Delete()
                }
            }