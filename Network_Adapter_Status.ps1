        # written by Elik and ErezSc

$ErrorActionPreference = 'SilentlyContinue'

$status = Get-NetAdapter | Select-Object -ExpandProperty "status" -Unique
if ($status -contains "Disabled") {
Write-Output "One of the Adapters is Down" | Out-File -FilePath "c:\install\AdapterStatus.txt" -Append
} elseif ($status -eq "Up") {
Remove-Item "c:\install\AdapterStatus.txt"
}