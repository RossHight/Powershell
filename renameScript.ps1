cd c:\users\rossh\onedrive\desktop\bluey
get-childitem | foreach { rename-item $_ $_.Name.Replace(".tvnz.web-dl.mp4", "") }
get-childitem | foreach { rename-item $_ $_.Name.Replace("bluey.", "") }
get-childitem | foreach { rename-item $_ $_.Name.Replace(".", " ") }