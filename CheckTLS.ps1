$netFramework = "HKLM:\SOFTWARE\Microsoft\NET Framework Setup\NDP\v4\Full"
$ssl20 = "HKLM:\SYSTEM\CurrentControlSet\Control\SecurityProviders\SCHANNEL\Protocols\SSL 2.0\"
$ssl30 = "HKLM:\SYSTEM\CurrentControlSet\Control\SecurityProviders\SCHANNEL\Protocols\SSL 3.0\"
$tls10 = "HKLM:\SYSTEM\CurrentControlSet\Control\SecurityProviders\SCHANNEL\Protocols\TLS 1.0\"
$tls11 = "HKLM:\SYSTEM\CurrentControlSet\Control\SecurityProviders\SCHANNEL\Protocols\TLS 1.1\"
$tls12 = "HKLM:\SYSTEM\CurrentControlSet\Control\SecurityProviders\SCHANNEL\Protocols\TLS 1.2\"
$strongcrypto = "HKLM:\SOFTWARE\WOW6432Node\Microsoft\.NETFramework\v2.0.50727",
"HKLM:\SOFTWARE\WOW6432Node\Microsoft\.NETFramework\v4.0.30319",
"HKLM:\SOFTWARE\Microsoft\.NETFramework\v2.0.50727",
"HKLM:\SOFTWARE\Microsoft\.NETFramework\v4.0.30319"

write-host ""
write-host ".NET Framework version:" -fore cyan
(Get-ItemProperty -Path $netFramework).version
start-sleep -seconds 1

write-host ""
write-host "Check SSL 2.0:"  -fore cyan
Get-ChildItem $ssl20
start-sleep -seconds 1

write-host ""
write-host "Check SSL 3.0:"  -fore cyan
Get-ChildItem $ssl30
start-sleep -seconds 1

write-host ""
write-host "Check TLS 1.0:"  -fore cyan
Get-ChildItem $tls10
start-sleep -seconds 1

write-host ""
write-host "Check TLS 1.1:"  -fore cyan
Get-ChildItem $tls11
start-sleep -seconds 1

write-host ""
write-host "Check TLS 1.2:"  -fore cyan
Get-ChildItem $tls12

write-host""
write-host "Checking for Strong Cryptography:" -fore cyan

$strongcrypto | ForEach-Object {Get-ItemProperty -Path $_} | select PSPath, SchUseStrongCrypto | ft