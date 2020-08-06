[CmdletBinding()]
param(
    $Settings,
    [String] $LoggingPrefix
)

Write-EdenBuildInfo "Connecting to azure tenant." $loggingPrefix

$pscredential = New-Object System.Management.Automation.PSCredential($Settings.ServicePrincipalId, (ConvertTo-SecureString $Settings.ServicePrincipalPassword))
Connect-AzAccount -ServicePrincipal -Credential $pscredential -Tenant $Settings.TenantId | Write-Verbose

Write-EdenBuildInfo "Generating link to the service monitoring dashboard in Azure." $loggingPrefix
Write-Host "" -ForegroundColor Blue
Write-Host "https://portal.azure.com/#@boundbybetter.com/resource/subscriptions/$((Get-AzSubscription).Id)/resourceGroups/$($Settings.EnvironmentName)-audio/providers/Microsoft.Insights/components/$($Settings.EnvironmentName)-audio-ai/applicationMap" -ForegroundColor Blue
Write-Host "" -ForegroundColor Blue
