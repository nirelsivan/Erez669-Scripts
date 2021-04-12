$Computer = read-host 'Enter RemoteMachine Name\IP Address'
$UserName = read-host 'Enter ADM User'
$password = read-host 'Enter ADM Password' -AsSecureString
$Newpass = [Runtime.InteropServices.Marshal]::PtrToStringAuto([Runtime.InteropServices.Marshal]::SecureStringToBSTR($password))
$Domain = "corp.supersol.co.il"
$UNCServer = "\\$Computer\C$"
net use /delete $UNCServer
net use $UNCServer $Newpass /user:$Domain\$UserName
explorer $UNCServer