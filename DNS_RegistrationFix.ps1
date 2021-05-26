﻿$networkConfig = Get-WmiObject Win32_NetworkAdapterConfiguration -filter "ipenabled = 'true'"
$class = [wmiclass]'Win32_NetworkAdapterConfiguration'
$class.SetDNSSuffixSearchOrder(@('suffix1','suffix2'))
$networkConfig.SetDynamicDNSRegistration($true,$true)
wmic /interactive:off nicconfig where TcpipNetbiosOptions=0 call SetTcpipNetbios 2
wmic /interactive:off nicconfig where TcpipNetbiosOptions=2 call SetTcpipNetbios 1
ipconfig /flushdns
ipconfig /registerdns
