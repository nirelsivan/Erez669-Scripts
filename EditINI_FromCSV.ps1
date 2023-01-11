# Retrieve the server name and extract the three digits from the end
$srvName = [System.Net.Dns]::GetHostName()
$1stNum = $srvName.Substring($srvName.Length -3 ,3)[0]
$2ndNum = $srvName.Substring($srvName.Length -3 ,3)[1]
$3rdNum = $srvName.Substring($srvName.Length -3 ,3)[2]

# Combine the three digits into a single string and convert it to an integer
$strOctet = "$1stNum$2ndNum$3rdNum"
$intOctet = [int]$strOctet

# Import the CSV file and get the contents of the INI file
$CSV = Import-Csv -LiteralPath \\reportsrv01\pub\Yarpa_Number.csv
$pirini = Get-Content -Path  C:\psoftw\PirRepl.ini

# Loop through the rows of the CSV file
foreach ($row in $CSV) {
    # If the value in the SNIF column of the current row matches the server name, update the INI file
    if ($row.SNIF -eq $intOctet) 
    {
        # Replace the third line of the INI file with the value from the YARPA column of the CSV file
        $pirini[2] = "snif=$($row.YARPA)"
        # Save the updated INI file
        Set-Content -LiteralPath C:\psoftw\PirRepl.ini -Value $pirini
    }
}