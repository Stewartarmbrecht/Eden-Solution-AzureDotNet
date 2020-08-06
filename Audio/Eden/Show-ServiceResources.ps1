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
Write-Host "Docs: http://localhost:8089/README.md" -ForegroundColor Blue
Write-Host "Infrastructure: https://portal.azure.com/#@boundbybetter.com/resource/subscriptions/$((Get-AzSubscription).Id)/resourceGroups/$($Settings.EnvironmentName)-audio/overview" -ForegroundColor Blue
Write-Host "Monitoring: https://portal.azure.com/#@boundbybetter.com/resource/subscriptions/$((Get-AzSubscription).Id)/resourceGroups/$($Settings.EnvironmentName)-audio/overview" -ForegroundColor Blue
Write-Host "Status Local: https://portal.azure.com/#@boundbybetter.com/resource/subscriptions/$((Get-AzSubscription).Id)/resourceGroups/$($Settings.EnvironmentName)-audio/overview" -ForegroundColor Blue
Write-Host "Status Staging: https://portal.azure.com/#@boundbybetter.com/resource/subscriptions/$((Get-AzSubscription).Id)/resourceGroups/$($Settings.EnvironmentName)-audio/overview" -ForegroundColor Blue
Write-Host "Status Production: https://portal.azure.com/#@boundbybetter.com/resource/subscriptions/$((Get-AzSubscription).Id)/resourceGroups/$($Settings.EnvironmentName)-audio/overview" -ForegroundColor Blue
Write-Host "" -ForegroundColor Blue
