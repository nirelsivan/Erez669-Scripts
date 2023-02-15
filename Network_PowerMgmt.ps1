clear
$ErrorActionPreference = 'silentlycontinue'
$nics = Get-WmiObject Win32_NetworkAdapter

foreach ($nic in $nics)
{
    $powerMgmt = Get-WmiObject MSPower_DeviceEnable -Namespace root\wmi | where {$_.InstanceName -match [regex]::Escape($nic.PNPDeviceID)}
    if ($powerMgmt.Enable -eq $True){
	    $powerMgmt.Enable = $False
	    $powerMgmt.psbase.Put()
     }
}

Get-NetAdapter | ForEach-Object {
    Set-NetAdapterAdvancedProperty -Name $_.Name -DisplayName "Reduce Speed On Power Down" -DisplayValue "Disabled" -NoRestart
    Set-NetAdapterAdvancedProperty -Name $_.Name -DisplayName "Energy Efficient Ethernet" -DisplayValue "Off" -NoRestart
    Set-NetAdapterAdvancedProperty -Name $_.Name -DisplayName "Ultra Low Power Mode" -DisplayValue "Disabled" -NoRestart
    Set-NetAdapterAdvancedProperty -Name $_.Name -DisplayName "system idle power saver" -DisplayValue "Disabled" -NoRestart
    Set-NetAdapterAdvancedProperty -Name $_.Name -DisplayName "Power Saving Mode" -DisplayValue "Disabled" -NoRestart
    Set-NetAdapterAdvancedProperty -Name $_.Name -DisplayName "wake on link settings" -DisplayValue "forced" -NoRestart
    Set-NetAdapterAdvancedProperty -Name $_.Name -DisplayName "Wake on magic packet when system is in the S0ix power state" -DisplayValue "Enabled" -NoRestart
    Set-NetAdapterAdvancedProperty -Name $_.Name -DisplayName "Wake from S0ix on Magic Packet" -DisplayValue "Enabled" -NoRestart
    Set-NetAdapterAdvancedProperty -Name $_.Name -DisplayName "Wake on magic packet" -DisplayValue "Enabled" -NoRestart
    Set-NetAdapterAdvancedProperty -Name $_.Name -DisplayName "Wake on pattern match" -DisplayValue "Enabled" -NoRestart
    Set-NetAdapterAdvancedProperty -Name $_.Name -DisplayName "WOL & Shutdown Link speed" -DisplayValue "Not Speed Down" -NoRestart
    Set-NetAdapterAdvancedProperty -Name $_.Name -DisplayName "Energy-Efficient Ethernet" -DisplayValue "Disabled" -NoRestart
}

$wifiAdapter = Get-NetAdapter | where {$_.InterfaceDescription -match "Wi-Fi"}
if ($wifiAdapter) {
    Disable-NetAdapter -Name $wifiAdapter.Name -Confirm:$false
}