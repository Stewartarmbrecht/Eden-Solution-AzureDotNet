[CmdletBinding()]
param(
    $Settings,
    [String] $LoggingPrefix
)

Write-EdenBuildInfo "Connecting to azure tenant." $loggingPrefix

$pscredential = New-Object System.Management.Automation.PSCredential($Settings.ServicePrincipalId, (ConvertTo-SecureString $Settings.ServicePrincipalPassword))
Connect-AzAccount -ServicePrincipal -Credential $pscredential -Tenant $Settings.TenantId | Write-Verbose

Write-EdenBuildInfo "Generating link to the services resource group in Azure." $loggingPrefix
Write-Host "" -ForegroundColor Blue
Write-Host "Click: https://portal.azure.com/#@boundbybetter.com/resource/subscriptions/$((Get-AzSubscription).Id)/resourceGroups/$($Settings.EnvironmentName)-audio/overview" -ForegroundColor Blue
Write-Host "" -ForegroundColor Blue
