$nics = Get-WmiObject Win32_NetworkAdapter | where {$_.Name.Contains('Realtek')}

foreach ($nic in $nics)
{
    $powerMgmt = Get-WmiObject MSPower_DeviceEnable -Namespace root\wmi | where {$_.InstanceName -match [regex]::Escape($nic.PNPDeviceID)}
    if ($powerMgmt.Enable -eq $True){
	    $powerMgmt.Enable = $False
	    $powerMgmt.psbase.Put()
     }
}

Set-NetAdapterAdvancedProperty -Name "Ethernet" -DisplayName "Energy-Efficient Ethernet" -DisplayValue "Disabled" -NoRestart
Set-NetAdapterAdvancedProperty -Name "Ethernet" -DisplayName "Power Saving Mode" -DisplayValue "Disabled" -NoRestart
Set-NetAdapterAdvancedProperty -Name "Ethernet" -DisplayName "Wake on magic packet" -DisplayValue "Enabled" -NoRestart
Set-NetAdapterAdvancedProperty -Name "Ethernet" -DisplayName "wake on magic packet when system is in the s0ix power state" -DisplayValue "Enabled" -NoRestart
Set-NetAdapterAdvancedProperty -Name "Ethernet" -DisplayName "WOL & Shutdown Link speed" -DisplayValue "Not Speed Down" -NoRestart
Disable-NetAdapter -Name Wi-Fi -Confirm:$false