Clear-Host

Write-Host " _______  __  .__   __.  _______      __  .__   __.     __        ______     _______ " -fore Cyan
Write-Host "|   ____||  | |  \ |  | |       \    |  | |  \ |  |    |  |      /  __  \   /  _____|" -fore Cyan
Write-Host "|  |__   |  | |   \|  | |  .--.  |   |  | |   \|  |    |  |     |  |  |  | |  |  __  " -fore Cyan
Write-Host "|   __|  |  | |  .    | |  |  |  |   |  | |  .    |    |  |     |  |  |  | |  | |_ | " -fore Cyan
Write-Host "|  |     |  | |  |\   | |  '--'  |   |  | |  |\   |    |  '----.|  '--'  | |  |__| | " -fore Cyan
Write-Host "|__|     |__| |__| \__| |_______/    |__| |__| \__|    |_______| \______/   \______| " -fore Cyan
Write-Host "by Ross Hight" -fore DarkCyan
Write-Host ""
Write-Host ""                                                                            

$Searchstring = read-host "Please enter the string to search for"
$path =  Read-Host "Please enter the path where the logs are located"
$Logs = Get-ChildItem -path $path -recurse -include "*.log" -Exclude "*High.log" -ErrorAction SilentlyContinue
$results = @()
$count = 1

foreach($Log in $Logs)  
{  
    $StringExist = Select-String -Path $log.fullname -pattern $Searchstring 
    if($StringExist)  
    {  
	write-host " "
       write-host "**" $count "**"
	$results += $log.fullname
	$parentPath = split-path -Path $log.fullname
	$superParentPath = split-path -Path $parentPath
	$leaf = Split-Path $Log -Leaf
	write-host $leaf -fore cyan
	write-host $superParentPath -fore darkcyan
	write-host "Total number of occurrences: " ($stringexist.linenumber).count -fore cyan
	write-host " "
	start-sleep -seconds .5
	$count += 1
    }  
}

write-host "END OF SEARCH."($count-1)"RESULTS FOUND."  -fore yellow
write-host " "

$choice = read-host "Would you like to open these log files now? (y/n)"

if($choice -eq 'y'){
	$results | ForEach-Object {invoke-item -Path $_}
}

