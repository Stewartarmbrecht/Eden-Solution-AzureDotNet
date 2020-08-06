[CmdletBinding()]
param(
    $Settings,
    [String] $LoggingPrefix
)

$resourceGroupName = "$($Settings.EnvironmentName)-audio".ToLower()
$apiName = "$($Settings.EnvironmentName)-audio".ToLower()

Write-EdenBuildInfo "Connecting to azure tenant using the following configuration:" $loggingPrefix

Write-EdenBuildInfo "SolutionName       : $($Settings.SolutionName)" $LoggingPrefix
Write-EdenBuildInfo "ServiceName        : $($Settings.ServiceName)" $LoggingPrefix
Write-EdenBuildInfo "EnvironmentName    : $($Settings.EnvironmentName)" $LoggingPrefix
Write-EdenBuildInfo "Region             : $($Settings.Region)" $LoggingPrefix
Write-EdenBuildInfo "ServicePrincipalId : $($Settings.ServicePrincipalId)" $LoggingPrefix
Write-EdenBuildInfo "TenantId           : $($Settings.TenantId)" $LoggingPrefix
Write-EdenBuildInfo "DeveloperId        : $($Settings.DeveloperId)" $LoggingPrefix

$pscredential = New-Object System.Management.Automation.PSCredential($Settings.ServicePrincipalId, (ConvertTo-SecureString $Settings.ServicePrincipalPassword))
Connect-AzAccount -ServicePrincipal -Credential $pscredential -Tenant $Settings.TenantId | Write-Verbose

Write-EdenBuildInfo "Switching the '$resourceGroupName/$apiName' azure functions app staging slot with production." $LoggingPrefix
$result = Switch-AzWebAppSlot -SourceSlotName "Staging" -DestinationSlotName "Production" -ResourceGroupName $resourceGroupName -Name $apiName
if ($VerbosePreference -ne 'SilentlyContinue') { $result }