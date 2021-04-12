# this script was written by erez schwartz

Import-Module ActiveDirectory
while ($true){
cls
write-host "Change MobilePhone number on ActiveDirectory"
write-host "`n" # for creating space
$UserName = read-host 'Enter AD Username'
write-host "`n" # for creating space
$cellphone = Get-ADUser $UserName -Properties mobile | select mobile

$exit = Read-Host "current mobile number is $cellphone do you want to change it? (y\n\c) c = clear Value"

if ($exit -eq 'c'){
Set-ADUser $UserName -clear mobile
write-host "`n" # for creating space
Write-Host "Mobile Number was Cleared Successfully, check AD in 5 minutes for verify"
}

if ($exit -eq 'n'){
write-host "`n" # for creating space
Write-Host "mobile number for $UserName was stay $cellphone"
}

if ($exit -eq 'y'){
write-host "`n" # for creating space
$phone = read-host 'enter new mobile phone number'
Set-ADUser $UserName -MobilePhone $Phone
write-host "`n" # for creating space
Write-Host "the new value for $UserName updated successfully, check AD in 5 minutes for verify"
}
Start-Sleep -s 05 # delay command
}