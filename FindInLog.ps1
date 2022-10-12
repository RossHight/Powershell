$Searchstring = read-host "Please enter the string to search for"
$path =  Read-Host "Please enter the path where the logs are located"
$Logs = Get-ChildItem -path $path -recurse -include *.log
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
	write-host "Line #: " $stringexist.linenumber -fore cyan
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

