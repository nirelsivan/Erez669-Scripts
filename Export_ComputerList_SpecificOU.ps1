$OUpath = 'OU=Test,OU=Workstations,DC=corp,DC=supersol,DC=co,DC=il'
$ExportPath = 'C:\Temp\Test.txt'
Get-ADComputer -Filter * -SearchBase $OUpath | Select-object Name | Out-File $ExportPath