[CmdletBinding()]
param()

$solutionName = "MyEdenSolution"
$serviceName = "Health"

try {
    $currentDirectory = Get-Location
    Set-Location $PSScriptRoot

    . ./Functions.ps1

    ./Configure-Environment.ps1 -Check

    $instanceName = $Env:InstanceName
    $region = $Env:Region

    $loggingPrefix = "$solutionName $serviceName Deploy Infrastructure $instanceName"

    $resourceGroupName = "$instanceName-health".ToLower()
    $deploymentFile = "./../Infrastructure/Infrastructure.json"

    Write-EdenInfo "Deploying the service infrastructure." $loggingPrefix

    Connect-AzureServicePrincipal $loggingPrefix

    Write-EdenInfo "Creating the resource group: $resourceGroupName." $loggingPrefix
    New-AzResourceGroup -Name $resourceGroupName -Location $region -Force | Write-Verbose

    Write-EdenInfo "Executing the deployment using: $deploymentFile." $loggingPrefix
    New-AzResourceGroupDeployment `
        -ResourceGroupName $resourceGroupName `
        -TemplateFile $deploymentFile `
        -InstanceName $instanceName `
        -AccountName $instanceName-DevOps `
        
        | Write-Verbose

    Write-EdenInfo "Deployed the service infrastructure." $loggingPrefix
    Set-Location $currentDirectory
}
catch {
    Set-Location $currentDirectory
    throw $_    
}
