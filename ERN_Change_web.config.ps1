$Snif = $env:computername.Substring(8,3)
$csvFile = "\\reportsrv01\pub\ERN.csv"
$webConfigFile = "D:\retalix\fpstore\WSGpos\web.config"

$Csv = Import-Csv $csvFile
$filteredRows = $Csv | Where-Object { $_.SNIF.PadLeft(3,'0') -eq $Snif }
$filteredRows | ForEach-Object {
    $ern = $_.ERN
    $content = Get-Content $webConfigFile
    $updatedContent = $content | ForEach-Object { $_ -replace "100276", $ern }
    Set-Content $webConfigFile $updatedContent
    break
}