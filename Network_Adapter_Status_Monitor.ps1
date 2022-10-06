#################################################################################
# Network Adapter Monitoring
# FileName: Network_Adapter_Status_Monitor.ps1
# Description: Monitors multiple Network adapters status
#              Designed specially for witness Servers
# Executing script: powershell Network_Adapter_Status_Monitor.ps1
#
# version: 2.0
# Author: Eli Kastika & Erez Schwartz
#################################################################################
$srvName = [System.Net.Dns]::GetHostName()
$1stNum = $srvName.Substring($srvName.Length -3 ,3)[0]
$2ndNum = $srvName.Substring($srvName.Length -3 ,3)[1]
$3rdNum = $srvName.Substring($srvName.Length -3 ,3)[2]

$Check1 = Test-Connection 10.11$1stNum.$2ndNum$3rdNum.9 -Quiet -Count 5
$check2 = Test-Connection 10.11$1stNum.$2ndNum$3rdNum.8 -Quiet -Count 5

echo "<metadata>MonitorTypeName=NetAdapterMon</metadata>"
if ($Check1) {
    echo "NetAdapterMon=NetworkAdapter-9,status=0"
} 
    else {
        echo "NetAdapterMon=NetworkAdapter-9,status=1"
    }

if ($Check2) {
    echo "NetAdapterMon=NetworkAdapter-8,status=0"
} 
    else {
        echo "NetAdapterMon=NetworkAdapter-8,status=1"
}
