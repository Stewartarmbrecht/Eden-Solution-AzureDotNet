[CmdletBinding()]
param(
    $Settings,
    [String] $LoggingPrefix
)

    $resourceGroupName = "$($Settings.EnvironmentName)-webui".ToLower()
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

    $accountNameA = "$($Settings.EnvironmentName)webuisaa"

    Write-EdenInfo "Getting the newly created storage account A." $LoggingPrefix
    $storageAccountA = Get-AzStorageAccount `
        -ResourceGroupName $resourceGroupName `
        -AccountName $accountNameA
    $ctxA = $storageAccountA.Context

    Write-EdenInfo "Enabling the static website storage A with an Index Document of 'index.html'." $LoggingPrefix
    Enable-AzStorageStaticWebsite `
        -Context $ctxA `
        -IndexDocument "index.html" 

    $accountNameB = "$($Settings.EnvironmentName)webuisab"

    Write-EdenInfo "Getting the newly created storage account B." $LoggingPrefix
    $storageAccountB = Get-AzStorageAccount `
        -ResourceGroupName $resourceGroupName `
        -AccountName $accountNameB
    $ctxB = $storageAccountB.Context

    Write-EdenInfo "Enabling the static website storage B with an Index Document of 'index.html'." $LoggingPrefix
    Enable-AzStorageStaticWebsite `
        -Context $ctxB `
        -IndexDocument "index.html" 
