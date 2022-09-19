<#
    Name        : CopyExchangeServerSettings.ps1
    Version     : 2.0.0.4
    Last Update : 2022/05/29
    Created by  : David Danino, Microsoft
    Usage       : Run from elevated instance of Exchange Management Shell on the target (new) Exchange server.
#>

ECHO "From which Exchange server would you like to copy settings from?"
$SOURCE = (Read-Host)
Get-ExchangeServer $SOURCE -ErrorAction Stop

ECHO "Updating AutoDiscover Sevice Connection Point..."
Get-ClientAccessService | FT Name,AutodiscoverServiceInternaluri -au
$CAS = Get-ClientAccessService $SOURCE | select AutodiscoverServiceInternaluri
Set-ClientAccessService (hostname) -AutodiscoverServiceInternaluri $CAS.AutodiscoverServiceInternaluri
Get-ClientAccessService | FT Name,AutodiscoverServiceInternaluri -au

ECHO "Copying Virtual Directory URL's..."
$MAPI = Get-MapiVirtualDirectory -Server $SOURCE -AdPropertiesOnly
Get-MapiVirtualDirectory -Server (hostname) | Set-MapiVirtualDirectory -InternalUrl $MAPI.InternalUrl -ExternalUrl $MAPI.ExternalUrl
$EWS = Get-WebServicesVirtualDirectory -Server $SOURCE -AdPropertiesOnly
Get-WebServicesVirtualDirectory -Server (hostname) | Set-WebServicesVirtualDirectory -InternalUrl $EWS.InternalUrl -ExternalUrl $EWS.ExternalUrl
$OAB = Get-OabVirtualDirectory -Server $SOURCE -AdPropertiesOnly
Get-OabVirtualDirectory -Server (hostname) | Set-OabVirtualDirectory -InternalUrl $OAB.InternalUrl -ExternalUrl $OAB.ExternalUrl
$OWA = Get-OwaVirtualDirectory -Server $SOURCE -AdPropertiesOnly
Get-OwaVirtualDirectory -Server (hostname) | Set-OwaVirtualDirectory -InternalUrl $OWA.InternalUrl -ExternalUrl $OWA.ExternalUrl -WarningAction SilentlyContinue
$ECP = Get-OwaVirtualDirectory -Server $SOURCE -AdPropertiesOnly
Get-EcpVirtualDirectory -Server (hostname) | Set-EcpVirtualDirectory -InternalUrl $ECP.InternalUrl -ExternalUrl $ECP.ExternalUrl -WarningAction SilentlyContinue
$OLA = Get-OutlookAnywhere -AdPropertiesOnly -Server $SOURCE
Get-OutlookAnywhere -AdPropertiesOnly -Server (hostname) | Set-OutlookAnywhere -InternalHostname $OLA.InternalHostname -DefaultAuthenticationMethod Negotiate -InternalClientsRequireSsl $True -WarningAction SilentlyContinue

Import-Module -Name WebAdministration
Get-ItemProperty -Path 'IIS:\Sites\*' | Set-ItemProperty -Name Logfile.enabled -Value $False
Restart-WebAppPool MSExchangeServicesAppPool
Restart-WebAppPool MSExchangeAutodiscoverAppPool

ECHO "Copying Exchange certificate..."
$CERT = Get-ExchangeCertificate -Server $SOURCE | ? {$_.Services -Like "*IIS*" -and $_.IsSelfSigned -eq $false} | select Thumbprint
$PASS = ConvertTo-SecureString "123456" -AsPlainText -Force
mkdir C:\temp -ErrorAction SilentlyContinue | Out-Null
$bincert = Export-ExchangeCertificate -Server $SOURCE -Thumbprint $CERT.Thumbprint -BinaryEncoded -Password (ConvertTo-SecureString -String '123456' -AsPlainText -Force)
[System.IO.File]::WriteAllBytes('C:\Temp\ExchangeCert-Temp.pfx', $bincert.FileData)
Import-ExchangeCertificate -Server (hostname) -FileData ([System.IO.File]::ReadAllBytes('\\localhost\C$\temp\ExchangeCert-Temp.pfx')) -PrivateKeyExportable $true -Password $PASS
Remove-Item "C:\temp\ExchangeCert-Temp.pfx" -ErrorAction SilentlyContinue -Confirm:$False
Enable-ExchangeCertificate -Thumbprint $CERT.Thumbprint -Services IIS -DoNotRequireSsl
Get-ExchangeCertificate | ? {$_.Services -Like "*IIS*" -and $_.IsSelfSigned -eq $false} | FL CertificateDomains,Thumbprint,NotAfter,Issuer,Services

ECHO "Script complete!"
ECHO "Please review error messages for skipped items."