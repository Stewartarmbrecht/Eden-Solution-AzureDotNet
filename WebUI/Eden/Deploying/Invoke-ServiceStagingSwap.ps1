[CmdletBinding()]
param(
    $Settings,
    [String] $LoggingPrefix
)

$resourceGroupName = "$($Settings.EnvironmentName)-webui".ToLower()
$proxyName = "$($Settings.EnvironmentName)-webuiproxy".ToLower()
Write-EdenInfo "Switching the '$resourceGroupName/$proxyName' proxy azure functions app staging slot with production." $loggingPrefix
$result = Switch-AzWebAppSlot `
    -SourceSlotName "Staging" `
    -DestinationSlotName "Production" `
    -ResourceGroupName $resourceGroupName `
    -Name $proxyName
if ($VerbosePreference -ne 'SilentlyContinue') { $result }
Write-EdenInfo "Finished switching the '$resourceGroupName/$proxyName' proxy azure functions app staging slot with production." $loggingPrefix
