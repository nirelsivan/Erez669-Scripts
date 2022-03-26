                                                   #Made By Erez Schwartz
$servers = "D:\temp\Servers.txt"
$computername = Get-Content $servers
$sourcefile = "c:\ps\cb8x64.bat"
#This section will install the software 
foreach ($computer in $computername) 
{
    $destinationFolder = "\\$computer\C$\ps"
    <#
       It will copy $sourcefile to the $destinationfolder. If the Folder does 
       not exist it will create it.
    #>

    if ((Test-Path -path $destinationFolder))
    {
          New-Item $destinationFolder -Type Directory -Force
    }
    Copy-Item -Path $sourcefile -Destination $destinationFolder
    Invoke-Command -ComputerName $computer -ScriptBlock {Start-Process -FilePath 'c:\ps\cb8x64.bat' -NoNewWindow -Wait -PassThru}

}
