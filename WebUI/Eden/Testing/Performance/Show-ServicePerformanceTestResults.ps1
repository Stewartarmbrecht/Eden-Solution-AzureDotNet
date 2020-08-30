[CmdletBinding()]
param(
    $Settings,
    [String] $LoggingPrefix
)

    Write-EdenInfo "Launching a browser to load the features test results report at './App/testresults/e2e/report.html'." $LoggingPrefix

    $pscredential = New-Object System.Management.Automation.PSCredential( `
        $Settings.ServicePrincipalId, `
        (ConvertTo-SecureString $Settings.ServicePrincipalPassword)
    )
    Connect-AzAccount -ServicePrincipal -Credential $pscredential -Tenant $Settings.TenantId | Write-Verbose

    $subscriptionId = (Get-AzSubscription -TenantId $Settings.TenantId).Id

    Write-Host "To access the Applicaiton Insights performance dashboard, click:" -ForegroundColor Blue
    Write-Host "https://portal.azure.com/#@boundbybetter.com/resource/subscriptions/$subscriptionId/resourceGroups/$($Settings.EnvironmentName)-webui/providers/Microsoft.Insights/components/$($Settings.EnvironmentName)-webuiproxy-ai/performance" -ForegroundColor Blue
    Write-Host "" -ForegroundColor Blue

    Write-Host "To view a json formated version of the performance test results go to:" -ForegroundColor Blue
    Write-Host "./Performance/TestResutls.json:" -ForegroundColor Blue
