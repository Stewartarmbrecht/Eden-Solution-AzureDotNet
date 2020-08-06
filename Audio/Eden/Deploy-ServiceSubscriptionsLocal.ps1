[CmdletBinding()]
param(
    $Settings,
    [String] $LoggingPrefix
)

    Write-EdenBuildInfo "Connecting to azure tenant using the following configuration:" $loggingPrefix

    Write-EdenBuildInfo "SolutionName       : $($Settings.SolutionName)" $LoggingPrefix
    Write-EdenBuildInfo "ServiceName        : $($Settings.ServiceName)" $LoggingPrefix
    Write-EdenBuildInfo "EnvironmentName    : $($Settings.EnvironmentName)" $LoggingPrefix
    Write-EdenBuildInfo "Region             : $($Settings.Region)" $LoggingPrefix
    Write-EdenBuildInfo "ServicePrincipalId : $($Settings.ServicePrincipalId)" $LoggingPrefix
    Write-EdenBuildInfo "TenantId           : $($Settings.TenantId)" $LoggingPrefix
    Write-EdenBuildInfo "DeveloperId        : $($Settings.DeveloperId)" $LoggingPrefix

    $pscredential = New-Object System.Management.Automation.PSCredential( `
        $Settings.ServicePrincipalId, `
        (ConvertTo-SecureString $Settings.ServicePrincipalPassword) `
    )
    Connect-AzAccount -ServicePrincipal -Credential $pscredential -Tenant $Settings.TenantId | Write-Verbose

    Write-EdenBuildInfo "Deploying the event grid subscriptions for the local functions app." $loggingPrefix

    $eventsResourceGroupName = "$($Settings.EnvironmentName)-events"
    $eventsSubscriptionDeploymentFile = "./Infrastructure/Subscriptions.local.json"
    $expireTime = Get-Date
    $expireTimeUtc = $expireTime.AddHours(1).ToUniversalTime().ToString("yyyy-MM-ddTHH:mm:ssZ")

    Write-EdenBuildInfo "Deploying to '$eventsResourceGroupName' events resource group." $loggingPrefix

    $result = New-AzResourceGroupDeployment `
        -ResourceGroupName $eventsResourceGroupName `
        -TemplateFile $eventsSubscriptionDeploymentFile `
        -InstanceName $Settings.EnvironmentName `
        -PublicUrlToLocalWebServer $Settings.PublicUrlToLocalWebServer `
        -UniqueDeveloperId $Settings.DeveloperId `
        -ExpireTimeUtc $expireTimeUtc
    if ($VerbosePreference -ne 'SilentlyContinue') { $result }
