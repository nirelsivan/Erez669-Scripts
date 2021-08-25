                            # Written by Erez Schwartz

$Source      = "\\sysinstalls\supergsrv\HdMatte\fonts-extra\Fonts\*"
$Destination = (New-Object -ComObject Shell.Application).Namespace(0x14)
$TempFolder  = "C:\install\Fonts"

# Create the source directory if it doesn't already exist

New-Item $TempFolder -Type Directory -Force | Out-Null
Copy-Item $Source $TempFolder -force

Get-ChildItem -Path $Source -Include '*.ttf','*.ttc','*.otf' -Recurse | ForEach {
    If (-not(Test-Path "C:\Windows\Fonts\$($_.Name)")) {

        $Font = "$TempFolder\$($_.Name)"
        
        # Copy font to local temporary folder
        Copy-Item $($_.FullName) -Destination $TempFolder
        
        # Install font
        $Destination.CopyHere($Font,0x10)

        }
}       

        # Delete temporary copy of font
        Remove-Item $Font -Force
        Remove-Item -LiteralPath “c:\install\fonts” -recurse -force