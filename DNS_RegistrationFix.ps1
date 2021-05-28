$networkConfig = Get-WmiObject Win32_NetworkAdapterConfiguration -filter "ipenabled = 'true'"
$class = [wmiclass]'Win32_NetworkAdapterConfiguration'
$class.SetDNSSuffixSearchOrder(@('suffix1','suffix2'))
$networkConfig.SetDynamicDNSRegistration($true,$false)
wmic /interactive:off nicconfig where TcpipNetbiosOptions=0 call SetTcpipNetbios 1
wmic /interactive:off nicconfig where TcpipNetbiosOptions=2 call SetTcpipNetbios 1
Clear-DnsClientCache -Verbose
Register-DnsClient -Verbose
timeout /t 5
