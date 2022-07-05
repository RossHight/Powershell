<#
.DESCRIPTION
This cmdlet searches through all folders within the provided log path and returns any log files that include the string provided.
.PARAMETER LogPath
Identifies the directory where the log files are stored.
.PARAMETER SearchString
Searches all log files in LogPath for the provided string.
.EXAMPLE
Search-Log -LogPath "C:\Users\TestUser\Documents\LogFolder" -SearchString "Error Message"
.NOTES
Module Name  : Search-Log
Created By    : Ross Hight
Date Coded    : 07/03/2022 23:50:00
#>
function Search-Log {
	
param(
    [Parameter(mandatory= $true)][string] $LogPath, #Identifies the directory where the log files are stored.
    [Parameter(mandatory= $true)][string] $SearchString #Searches all log files in LogPath for the provided string.
    )

$count = 0
$Logs = Get-ChildItem -path $LogPath -recurse -include *.log

foreach($Log in $Logs)  
{  
    $StringExist = Select-String -Path $log.fullname -pattern $Searchstring 
    if($StringExist)  
    {  
    $count += 1
	write-host ""
    write-host "**" $count "**"
	$parentPath = split-path -Path $log.fullname
	$superParentPath = split-path -Path $parentPath
	$leaf = Split-Path $Log -Leaf
	write-host $leaf -fore cyan
	write-host $superParentPath -fore darkcyan
	write-host " "
	start-sleep -seconds .5
    }  
}

write-host "END OF SEARCH."($count)"RESULTS FOUND."  -fore yellow
write-host " "

}

Export-ModuleMember -Function 'Search-Log'
