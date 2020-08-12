[CmdletBinding()]
param(
    $Settings,
    [String] $LoggingPrefix
)

    $resourceGroupName = "$($Settings.EnvironmentName)-audio".ToLower()
    $deploymentFile = "./Infrastructure/Infrastructure.json"

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

    Write-EdenInfo "Creating the resource group: $resourceGroupName." $LoggingPrefix
    New-AzResourceGroup -Name $resourceGroupName -Location $Settings.Region -Force | Write-Verbose

    Write-EdenInfo "Executing the deployment using: '$deploymentFile'." $LoggingPrefix
    New-AzResourceGroupDeployment `
        -ResourceGroupName $resourceGroupName `
        -TemplateFile $deploymentFile `
        -EnvironmentName $Settings.EnvironmentName | Write-Verbose
