function Main-Menu {
	do{
		write-host "1. Create Files"
		write-host "2. Randomize File Info"
		
		$menuresponse = read-host [Enter Selection]
		switch ($menuresponse){
			"1" {Create-Files}
			"2" {Random-Info}
		}
	}
	until (1..2 -contains $menuresponse)
}

function Create-Files {
$itemcount = read-host "How many items do you want to create?"
$itemtype = read-host "What type of files do you want to create?"
$path = read-host "Where would you like the files to be created?"

1..$itemcount | foreach-object {new-item -Path $path -Name "Doc$_$itemtype"} 
}

function Random-Info {
$Start = Get-Date '01.01.1990' #change to earliest desired date
$End = Get-Date '08.01.2022' # change to latest desired date
$path = read-host "Where are the files located?"
$files =  Get-ChildItem -Path $path -File
$count = 0
$totalcount = $files.count

foreach($object in $files){ 
$RandomName = Get-Random (Get-Content -Path $object.fullname)
$RandomDate = Get-Random -Minimum $Start.Ticks -Maximum $End.Ticks

$object.CreationTime = [datetime]$RandomDate
$object.LastWriteTime = [datetime]$RandomDate
$object.LastAccessTime = [datetime]$RandomDate
$count = $count + 1
start-sleep -seconds .1
write-host ""
write-host "$count/$totalcount Complete"
write-host ""
}
}

Main-Menu