$path = read-host "Please enter the location where the ZIP files are located" 

#Create temporary drive to shorten the filepath and avoid "Path Too Long" errors
subst q: $path
$shortpath = "q:\"

#Get the total number of items to be processed for calculating job completion percentage
$count = (Get-ChildItem -Path $path -Recurse -Filter *.zip -Exclude LogArchive*  | Measure-Object).count
$progress = 0
write-host ""

Get-ChildItem -Path $shortpath -Recurse -Filter *.zip -Exclude LogArchive* | ForEach-Object {
	$n=($_.Fullname.trimend('.zip'));
	if (test-path -path $n){
		$progress = $progress + 1
		write-host (($progress/$count).tostring("P")) " -- "$_.Fullname "is already Unzipped" -fore red
		write-host ""
		Start-Sleep -Seconds .75
	} else {
		Expand-Archive -Path $_.Fullname -DestinationPath $n -Force
		$progress = $progress + 1
		write-host (($progress/$count).tostring("P")) " -- "$_.Fullname "has been unzipped." -fore green
		write-host ""
		Start-Sleep -Seconds .75
	}
}
write-host "FILE EXTRACTION COMPLETE" -fore yellow
write-host ""

$choice = read-host "Would you like to open the folder location (y/n)"
if($choice -eq 'y'){
	Invoke-Item $path
	#Remove temporary drive
	subst q: /d
	Exit
} else {
	#Remove temporary drive
	subst q: /d
	Exit
}