                        # written by Eli Kastika and Erez Schwartz

$name = Get-NetAdapter | ? status -ne  up | Select-Object -ExpandProperty "name" -Unique
$name1 = Get-NetAdapter | ? status -eq up | Select-Object -ExpandProperty "name" -Unique 
$status = Get-NetAdapter | Select-Object -ExpandProperty "status" -Unique
$Status1 = Get-NetAdapter | Select-Object -ExpandProperty "status" -Unique -First 1
$Status2 = Get-NetAdapter | Select-Object -ExpandProperty "status" -Unique -last 1 
$first = Get-NetConnectionProfile | Select-Object -ExpandProperty InterfaceAlias -First 1 -Unique
$Sec = Get-NetConnectionProfile | Select-Object -ExpandProperty InterfaceAlias -last 1 -Unique
if ($Status -contains "Disabled" -or $status -contains "Disconnected") {
echo "NetAdapterMonitor=$name,Status=1"
echo "NetAdapterMonitor=$name1,Status=0"
} elseif ($status -eq "Up") {
echo "NetAdapterMonitor=$first,Status=0"
echo "NetAdapterMonitor=$sec,Status=0"
}
