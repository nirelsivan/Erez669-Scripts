#-------------------- Input --------------------#
$InputFilePath = "C:\temp\config.ini";
$OutputFilePath = "C:\temp\config.ini";
$LineNumber=7;
$Content="UpdateServer=true";
#-------------------- Command ------------------#
$Count=0; $Result = cat $InputFilePath | % {$Count++; if($Count -eq $LineNumber){ Write-Output $Content; Write-Output $_ } else { Write-Output $_ }}
$Result > $OutputFilePath;
#--------------------- End ---------------------#