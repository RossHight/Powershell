#Change the prompt text here to match the folder naming that you use for each customer's logs.  For example, I use the last 4 characters of the case number.
$case = read-host "Enter the last 4 digits of the case number"
$Searchstring = read-host "Enter the string to search for"
$count = 1
#Change $path to the directory where you keep your customer logs
$path = "C:\Users\ross.hight\Documents\Customer Files\/$case"
$Logs = Get-ChildItem -path $path -recurse -include *.log

foreach($Log in $Logs)  
{  
    $StringExist = Select-String -Path $log.fullname -pattern $Searchstring 
    if($StringExist)  
    {  
	write-host " "
       write-host "**" $count "**"
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