$case = read-host "Enter the last 4 of the case number"
$path = "C:\Users\ross.hight\Documents\Customer Files\/$case" 
$count = (Get-ChildItem -Path $path -Recurse -Filter *.zip -Exclude LogArchive*  | Measure-Object).count
$progress = 0
write-host ""

Get-ChildItem -Path $path -Recurse -Filter *.zip -Exclude LogArchive* | ForEach-Object {
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