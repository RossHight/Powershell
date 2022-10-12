<#
Description:
Script to upload logs from the local machine to the SupportLogs folder for use with JIRA tickets.
#>

$LocalLogs = read-host "Type the path where the customer logs are located. (eg., C:\Users\ross.hight\Documents\Customer Files...)"
#$LocalLogs = $LocalLogs + "\*"
$ParentFolder = Split-Path $LocalLogs -leaf
$JIRA = read-host "Please enter the JIRA # (eg,. ADO-123456)"
$SupportLogs = "\\Avepoint.com\resources\SupportLogs\"
$DestinationLogPath = $SupportLogs + $JIRA

	#Creates the JIRA folder in SupportLogs if it does not already exist
	if(!(test-path $DestinationLogPath)){
		New-Item -Itemtype Directory -Path $SupportLogs -Name $JIRA -erroraction SilentlyContinue
	#Copy files from local to new SupportLogs folder
	write-host "Copying files from $LocalLogs to $DestinationLogPath"
	Copy-Item -path $LocalLogs -destination $DestinationLogPath -recurse -erroraction SilentlyContinue
	write-host "File Copy Complete. Opening folder for validation check." -fore Yellow
	write-host "$DestinationLogPath\$ParentFolder" -fore magenta
	
	} else {
	
	#Copy files from local to new SupportLogs folder
	write-host "Copying files from $LocalLogs to $DestinationLogPath"
	Copy-Item -path $LocalLogs -destination $DestinationLogPath -recurse -erroraction SilentlyContinue
	write-host "File Copy Complete. Opening folder for validation check." -fore Yellow
	write-host "$DestinationLogPath\$ParentFolder" -fore magenta
	}
	#copy the upload path to the clipboard
	Set-Clipboard "$DestinationLogPath\$ParentFolder"
	
	#Open the new folder to confirm files are uploaded
	Invoke-Item $DestinationLogPath
	
