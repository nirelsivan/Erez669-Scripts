$complist = gc "\\myserver\PowerShell\Servers.txt"
$Results = "c:\temp\Results.txt"

$OutputMessage = @()

foreach($comp in $complist){
    
    $pingtest = Test-Connection -ComputerName $comp -Quiet -Count 2 -ErrorAction SilentlyContinue

    if($pingtest){
         write-host $comp is online
         $OutputMessage += ("$comp is online")
     }
    else{
         write-host $comp is not reachable
         $OutputMessage += ("$comp is not reachable")
     }
     
}

$OutputMessage | Out-File $Results -Verbose -Append
