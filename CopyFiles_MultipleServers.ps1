     #Made By Erez Schwartz

# This file contains the list of servers you want to copy files/folders to
$servers = gc "D:\temp\Servers.txt"
 
# This is the file/folder(s) you want to copy to the servers in the $computer variable
$source = "C:\Fix_IIS"
 
# The destination location you want the file/folder(s) to be copied to
$destination = "d$\IvantiShare\Packages\Servers_PL_SL\Server2019\"
 
foreach ($server in $servers) {
if ((Test-Path -Path \\$server\$destination)) {
Copy-Item $source -Destination \\$server\$destination -Recurse -Verbose -Force
} else {
"\\$server\$destination is not reachable or does not exist"
}
}