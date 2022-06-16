$csvFiles = Get-ChildItem (".\Testing")
    $Excel = New-Object -ComObject excel.application
    $Excel.visible = $True
    $Excel.sheetsInNewWorkbook = $csvFiles.Count
    $workbooks = $Excel.Workbooks.Add()
    $CSVSheet = 1
	        Write-Host "Checkpoint 1"

    Foreach ($CSV in $csvFiles) {
        $worksheets = $workbooks.worksheets
        $CSVFullPath = $CSV.FullName
		        Write-Host "Checkpoint 2"

        $SheetName = ($CSV.name -split "\.")[0]
        $worksheet = $worksheets.Item($CSVSheet)
        $worksheet.Name = $SheetName
		        Write-Host "Checkpoint 3"

        $CsvContents = Import-Csv $CSVFullPath
        $StartRowNum = 1
        $StartColumnNum = 1
		        Write-Host "Checkpoint 4"

        $EndRowNum = $CsvContents.Count + 1
        $EndColumnNum = ($CsvContents | Get-Member | Where-Object { $_.MemberType -eq 'NoteProperty' }).Count
        $Range = $worksheet.Range($worksheet.Cells($StartRowNum, $StartColumnNum), $worksheet.Cells($EndRowNum, $EndColumnNum))
		        Write-Host "Checkpoint 5"

        $worksheet.UsedRange.EntireColumn.AutoFit()
        $worksheet.CellFormat.ShrinkToFit
        $objRange = $worksheet.UsedRange
		        Write-Host "Checkpoint 6"
    }