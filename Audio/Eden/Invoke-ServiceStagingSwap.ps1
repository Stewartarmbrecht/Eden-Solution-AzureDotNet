[CmdletBinding()]
param(
    $Settings,
    [String] $LoggingPrefix
)

$resourceGroupName = "$($Settings.EnvironmentName)-audio".ToLower()
$apiName = "$($Settings.EnvironmentName)-audio".ToLower()

Write-EdenInfo "Connecting to azure tenant using the following configuration:" $loggingPrefix

Write-EdenInfo "SolutionName       : $($Settings.SolutionName)" $LoggingPrefix
Write-EdenInfo "ServiceName        : $($Settings.ServiceName)" $LoggingPrefix
Write-EdenInfo "EnvironmentName    : $($Settings.EnvironmentName)" $LoggingPrefix
Write-EdenInfo "Region             : $($Settings.Region)" $LoggingPrefix
Write-EdenInfo "ServicePrincipalId : $($Settings.ServicePrincipalId)" $LoggingPrefix
Write-EdenInfo "TenantId           : $($Settings.TenantId)" $LoggingPrefix
Write-EdenInfo "DeveloperId        : $($Settings.DeveloperId)" $LoggingPrefix

$pscredential = New-Object System.Management.Automation.PSCredential($Settings.ServicePrincipalId, (ConvertTo-SecureString $Settings.ServicePrincipalPassword))
Connect-AzAccount -ServicePrincipal -Credential $pscredential -Tenant $Settings.TenantId | Write-Verbose

Write-EdenInfo "Switching the '$resourceGroupName/$apiName' azure functions app staging slot with production." $LoggingPrefix
$result = Switch-AzWebAppSlot -SourceSlotName "Staging" -DestinationSlotName "Production" -ResourceGroupName $resourceGroupName -Name $apiName
if ($VerbosePreference -ne 'SilentlyContinue') { $result }