#Specify tenant admin and site URL
$cred = Get-Credentials
$SiteURL= read-host "Enter the destination Site URL"
$Folder= read-host "Please enter the Local path you wish to upload"
$DocLibName= read-host "Please enter the destination Document Library name" #Destination document library

#Bind to site collection
$Context=New-Object Microsoft.SharePoint.Client.ClientContext($SiteURL)
$Credentials=New-Object Microsoft.SharePoint.Client.SharePointOnlineCredentials($cred.username,$cred.password)
$Context.Credentials=$Credentials

#Retrieve list
$List=$Context.Web.Lists.GetByTitle($DocLibName)
$Context.Load($List)
$Context.ExecuteQuery()

#Upload file
Foreach ($File in (dir $Folder -File))
{
$FileStream=New-ObjectIO.FileStream($File.FullName,[System.IO.FileMode]::Open)
$FileCreationInfo=New-ObjectMicrosoft.SharePoint.Client.FileCreationInformation
$FileCreationInfo.Overwrite=$true
$FileCreationInfo.ContentStream=$FileStream
$FileCreationInfo.URL =$File
$Upload=$List.RootFolder.Files.Add($FileCreationInfo)
$Context.Load($Upload)
$Context.ExecuteQuery()
}