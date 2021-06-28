while ($true) {
cls
write-host "Get Printer List from Printer Server"
write-host "`n" # for creating space
$printserver = read-host "enter printer server name"
Get-Printer -ComputerName $printserver | select name, portname > "\\10.251.10.251\Supergsrv\HdMatte\NetworkPrinterList\PrinterList-$printserver.txt"
Invoke-Item "\\10.251.10.251\Supergsrv\HdMatte\NetworkPrinterList\PrinterList-$printserver.txt"
}
$while