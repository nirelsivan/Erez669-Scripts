$nics = Get-WmiObject Win32_NetworkAdapter | where {$_.Name.Contains('Intel')}

foreach ($nic in $nics)
{
    $powerMgmt = Get-WmiObject MSPower_DeviceEnable -Namespace root\wmi | where {$_.InstanceName -match [regex]::Escape($nic.PNPDeviceID)}
    if ($powerMgmt.Enable -eq $True){
	    $powerMgmt.Enable = $False
	    $powerMgmt.psbase.Put()
     }
}

Set-NetAdapterAdvancedProperty -Name "Ethernet" -DisplayName "Reduce Speed On Power Down" -DisplayValue "Disabled" -NoRestart
Set-NetAdapterAdvancedProperty -Name "Ethernet" -DisplayName "Energy Efficient Ethernet" -DisplayValue "Off" -NoRestart
Set-NetAdapterAdvancedProperty -Name "Ethernet" -DisplayName "Ultra Low Power Mode" -DisplayValue "Disabled" -NoRestart
Set-NetAdapterAdvancedProperty -Name "Ethernet" -DisplayName "system idle power saver" -DisplayValue "Disabled" -NoRestart
Set-NetAdapterAdvancedProperty -Name "Ethernet" -DisplayName "Power Saving Mode" -DisplayValue "Disabled" -NoRestart
Set-NetAdapterAdvancedProperty -Name "Ethernet" -DisplayName "wake on link settings" -DisplayValue "forced" -NoRestart
Set-NetAdapterAdvancedProperty -Name "Ethernet" -DisplayName "Wake on magic packet" -DisplayValue "Enabled" -NoRestart
Set-NetAdapterAdvancedProperty -Name "Ethernet" -DisplayName "WOL & Shutdown Link speed" -DisplayValue "Not Speed Down" -NoRestart
Set-NetAdapterAdvancedProperty -Name "Ethernet" -DisplayName "Energy-Efficient Ethernet" -DisplayValue "Disabled" -NoRestart
Disable-NetAdapter -Name Wi-Fi -Confirm:$false