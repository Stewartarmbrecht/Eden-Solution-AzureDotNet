[CmdletBinding()]
param(
    $Settings,
    [String] $LoggingPrefix
)

    $resourceGroupName = "$($Settings.EnvironmentName)-audio".ToLower()
    $deploymentFile = "./Infrastructure/Infrastructure.json"

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

    Write-EdenBuildInfo "Creating the resource group: $resourceGroupName." $LoggingPrefix
    New-AzResourceGroup -Name $resourceGroupName -Location $Settings.Region -Force | Write-Verbose

    Write-EdenBuildInfo "Executing the deployment using: '$deploymentFile'." $LoggingPrefix
    New-AzResourceGroupDeployment `
        -ResourceGroupName $resourceGroupName `
        -TemplateFile $deploymentFile `
        -EnvironmentName $Settings.EnvironmentName | Write-Verbose
