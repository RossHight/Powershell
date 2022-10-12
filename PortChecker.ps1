
<#PSScriptInfo

.VERSION 1.0.1

.GUID d5249e34-dfeb-4748-aba0-b9ab5f171ddc

.AUTHOR Ross.Hight

.COMPANYNAME

.COPYRIGHT

.TAGS

.LICENSEURI

.PROJECTURI

.ICONURI

.EXTERNALMODULEDEPENDENCIES 

.REQUIREDSCRIPTS

.EXTERNALSCRIPTDEPENDENCIES

.RELEASENOTES


.PRIVATEDATA

#>

<# 

.DESCRIPTION 
 Checks all processes which are using a specified port number 

#> 

Param()


## Get all services using specific port
##Change '$port' to the port you wish to check

$again = 'y'

while($again -eq 'y'){
	write-host ""
	$port = read-host "What port would you like to check?"
if(Get-NetTCPConnection | where {($_.RemotePort -eq $port)}) {
	Get-NetTCPConnection | where {($_.RemotePort -eq $port)}| select LocalAddress, LocalPort, RemotePort, @{Name="Process"; Expression={(Get-Process -id $_.owningprocess).ProcessName}}, @{Name="PID"; Expression={(Get-Process -id $_.owningprocess).Id}} | ft
	
	write-host "`nPort check complete." -fore yellow
	
} else {
	write-host "`nNo services are running on port $port." -fore cyan
}

$again = read-host "`nWould you like to check another port? (y/n)"
}
write-host "`nClosing the program now." -fore yellow
start-sleep -seconds 2
clear-host
