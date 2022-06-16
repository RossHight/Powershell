## Get all services using specific port
##Change '$port' to the port you wish to check

$again = 'y'

while($again -eq 'y'){
$port = read-host "What port would you like to check?"
if(Get-NetTCPConnection | where {($_.RemotePort -eq $port)}) {
	Get-NetTCPConnection | where {($_.RemotePort -eq $port)}| select LocalAddress, LocalPort, RemotePort, @{Name="Process"; Expression={(Get-Process -id $_.owningprocess).ProcessName}}, @{Name="PID"; Expression={(Get-Process -id $_.owningprocess).Id}} | ft
	
	write-host "Port check complete." -fore yellow
	write-host ""
	
} else {
	write-host ""
	write-host "No ports open on port $port." -fore cyan
	write-host ""
}

$again = read-host "Would you like to check another port? (y/n)"
}
	