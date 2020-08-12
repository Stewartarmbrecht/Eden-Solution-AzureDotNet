[CmdletBinding()]
param(
    $Settings,
    [String] $LoggingPrefix
)

    Write-EdenInfo "Connecting to azure tenant using the following configuration:" $loggingPrefix

    Write-EdenInfo "SolutionName       : $($Settings.SolutionName)" $LoggingPrefix
    Write-EdenInfo "ServiceName        : $($Settings.ServiceName)" $LoggingPrefix
    Write-EdenInfo "EnvironmentName    : $($Settings.EnvironmentName)" $LoggingPrefix
    Write-EdenInfo "Region             : $($Settings.Region)" $LoggingPrefix
    Write-EdenInfo "ServicePrincipalId : $($Settings.ServicePrincipalId)" $LoggingPrefix
    Write-EdenInfo "TenantId           : $($Settings.TenantId)" $LoggingPrefix
    Write-EdenInfo "DeveloperId        : $($Settings.DeveloperId)" $LoggingPrefix

    $pscredential = New-Object System.Management.Automation.PSCredential( `
        $Settings.ServicePrincipalId, `
        (ConvertTo-SecureString $Settings.ServicePrincipalPassword) `
    )
    Connect-AzAccount -ServicePrincipal -Credential $pscredential -Tenant $Settings.TenantId | Write-Verbose

    Write-EdenInfo "Deploying the event grid subscriptions for the local functions app." $loggingPrefix

    $eventsResourceGroupName = "$($Settings.EnvironmentName)-events"
    $eventsSubscriptionDeploymentFile = "./Infrastructure/Subscriptions.local.json"
    $expireTime = Get-Date
    $expireTimeUtc = $expireTime.AddHours(1).ToUniversalTime().ToString("yyyy-MM-ddTHH:mm:ssZ")

    Write-EdenInfo "Deploying to '$eventsResourceGroupName' events resource group." $loggingPrefix

    $result = New-AzResourceGroupDeployment `
        -ResourceGroupName $eventsResourceGroupName `
        -TemplateFile $eventsSubscriptionDeploymentFile `
        -InstanceName $Settings.EnvironmentName `
        -PublicUrlToLocalWebServer $Settings.PublicUrlToLocalWebServer `
        -UniqueDeveloperId $Settings.DeveloperId `
        -ExpireTimeUtc $expireTimeUtc
    if ($VerbosePreference -ne 'SilentlyContinue') { $result }
