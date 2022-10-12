[string]$tenantInfo = Read-Host "Please enter the Tenant ID or Domain"

$results = (Invoke-WebRequest -Uri "https://login.microsoftonline.com/$tenantInfo/.well-known/openid-configuration")

$resultsContentJSON = $results.Content

$resultsContent = $resultsContentJSON | Convertfrom-JSON

$tenantID = $($resultsContent.issuer -Split "/")[-2]

start-sleep -seconds 1

write-host ""
write-host "Tenant ID: "$tenantID -fore DarkCyan
write-host "Tenant Region Scope: "$resultsContent.tenant_region_scope -fore Cyan
write-host "Tenant Region Sub Scope: " $resultsContent.tenant_region_sub_scope -fore DarkCyan
write-host ""