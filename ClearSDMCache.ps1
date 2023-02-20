Clear-Host

$FolderName1 = "C:\Program Files (x86)\LANDesk\LDClient\sdmcache\"
$FolderName2 = "C:\Program Files\LANDesk\LDClient\sdmcache\"
$FolderName3 = "D:\SDMCACHE\"

# Check if the folder exists at path $FolderName1
if (Test-Path $FolderName1) {
    Remove-Item -LiteralPath $FolderName1 -Recurse -Force
    New-Item $FolderName1 -ItemType Directory -Force
}

# Check if the folder exists at path $FolderName2
if (Test-Path $FolderName2) {
    Remove-Item -LiteralPath $FolderName2 -Recurse -Force
    New-Item $FolderName2 -ItemType Directory -Force
}

# Check if the folder exists at path $FolderName3
if (Test-Path $FolderName3) {
    Remove-Item -LiteralPath $FolderName3 -Recurse -Force
    New-Item $FolderName3 -ItemType Directory -Force
}