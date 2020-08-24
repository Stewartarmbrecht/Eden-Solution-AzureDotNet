[CmdletBinding()]
param(
    $Settings,
    [String] $LoggingPrefix
)

$resourceGroupName = "$($Settings.EnvironmentName)-webui".ToLower()

Write-EdenInfo "Connecting to azure tenant using the following configuration:" $loggingPrefix

Write-Verbose "SolutionName       : $($Settings.SolutionName)"
Write-Verbose "ServiceName        : $($Settings.ServiceName)"
Write-Verbose "EnvironmentName    : $($Settings.EnvironmentName)"
Write-Verbose "Region             : $($Settings.Region)"
Write-Verbose "ServicePrincipalId : $($Settings.ServicePrincipalId)"
Write-Verbose "TenantId           : $($Settings.TenantId)"
Write-Verbose "DeveloperId        : $($Settings.DeveloperId)"

$pscredential = New-Object System.Management.Automation.PSCredential($Settings.ServicePrincipalId, (ConvertTo-SecureString $Settings.ServicePrincipalPassword))
Connect-AzAccount -ServicePrincipal -Credential $pscredential -Tenant $Settings.TenantId | Write-Verbose

Write-EdenInfo "Determining the staging site (A or B)." $LoggingPrefix
$stagingSite = "B"
try
{
    $response = Invoke-WebRequest `
        -Uri "https://$($Settings.EnvironmentName)-webuiproxy.azurewebsites.net/site" `
        -ErrorAction Stop
   
    # This will only execute if the Invoke-WebRequest is successful.
    $statusCode = $response.StatusCode
}
catch
{
    $statusCode = $_.Exception.Response.StatusCode.value__
}
if ($statusCode -ne 200 -or ($statusCode -eq 200 -and $response.Content -eq "B")) {
    $stagingSite = "A"
}
Write-EdenInfo "Using site '$stagingSite'." $LoggingPrefix

$accountName = "$($Settings.EnvironmentName)webuisa$($stagingSite.ToLower())"
Write-EdenInfo "Getting the storage account: '$accountName'." $LoggingPrefix
$storageAccount = Get-AzStorageAccount `
    -ResourceGroupName $resourceGroupName `
    -Name $accountName
$ctx = $storageAccount.Context

$distrFolder = "./.dist/$($Settings.EnvironmentName)/App/*"

Write-EdenInfo "Uploading the published application '$distrFolder' to the static website '$accountName'." $LoggingPrefix
Get-ChildItem -Path $distrFolder | Set-AzStorageblobcontent `
        -Container `$web `
        -Context $ctx `
        -Force `
        -Properties @{ ContentType = "text/html; charset=utf-8";}
Write-EdenInfo "Finished uploading the published application to the static website '$accountName'." $LoggingPrefix

Write-EdenInfo "Access the application at '$($storageAccount.PrimaryEndpoints.Web)'." $LoggingPrefix

Write-EdenInfo "Publishing the functions proxy app pointed at site: '$stagingSite'." $LoggingPrefix

Write-EdenInfo "Copying the proxies.json file to the dist folder." $LoggingPrefix
Copy-Item "./Proxy/proxies.json" -Destination "./.dist/$($Settings.EnvironmentName)/Proxy"

Write-EdenInfo "Replacing [SLOT] with '$stagingSite' in the copied proxies file." $LoggingPrefix
((Get-Content -Path "./.dist/$($Settings.EnvironmentName)/Proxy/proxies.json" -Raw) `
    -replace "\[SITE\]","$stagingSite") `
     | Set-Content -Path "./.dist/$($Settings.EnvironmentName)/Proxy/proxies.json"

Write-EdenInfo "Creating the deployment zip for the proxy function app." $LoggingPrefix
$path =  "./.dist/$($Settings.EnvironmentName)/Proxy/proxies.json"
$destinationFolder = "./.dist/$($Settings.EnvironmentName)/Proxy"

Write-EdenInfo "Removing the proxy function app package." $loggingPrefix 
Remove-Item -Path "$destinationFolder/app.zip" -Recurse -Force -ErrorAction Ignore

Write-EdenInfo "Creating the proxy function app dist folder." $loggingPrefix
$result = New-Item -Path $destinationFolder -ItemType "directory" -Force
if($VerbosePreference -ne 'SilentlyContinue') { $result }

Write-EdenInfo "Creating the proxy function app package." $loggingPrefix
Compress-Archive -Path $path -DestinationPath "$destinationFolder/app.zip" -Force

$proxyName = "$($Settings.EnvironmentName)-webuiproxy".ToLower()
$proxyFilePath = "$destinationFolder/app.zip"

Write-EdenInfo "Deploying the proxy site (azure functions app) using zip from '$proxyFilePath' to group '$resourceGroupName', app '$proxyName' on the staging slot." $loggingPrefix
$result = Publish-AzWebApp `
    -ResourceGroupName $resourceGroupName `
    -Name $proxyName `
    -Slot Staging `
    -ArchivePath (Resolve-Path $proxyFilePath) `
    -Force
if ($VerbosePreference -ne 'SilentlyContinue') { $result }

Write-EdenInfo "Finished building the proxy function app package." $loggingPrefix