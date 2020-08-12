[CmdletBinding()]
param()
$currentDirectory = Get-Location
Set-Location $PSScriptRoot

. ./Functions.ps1

./Configure-Environment.ps1

$instanceName = $Env:InstanceName
$region = $Env:Region

$loggingPrefix = "MyEdenSolution Audio Deploy Infrastructure $instanceName"

$resourceGroupName = "$instanceName-audio".ToLower()
$deploymentFile = "./../Infrastructure/Infrastructure.json"

Write-EdenInfo "Deploying the service infrastructure." $loggingPrefix

Connect-AzureServicePrincipal $loggingPrefix

Write-EdenInfo "Creating the resource group: $resourceGroupName." $loggingPrefix
New-AzResourceGroup -Name $resourceGroupName -Location $region -Force | Write-Verbose

Write-EdenInfo "Executing the deployment using: $deploymentFile." $loggingPrefix
New-AzResourceGroupDeployment -ResourceGroupName $resourceGroupName -TemplateFile $deploymentFile -InstanceName $instanceName | Write-Verbose

Write-EdenInfo "Deployed the service infrastructure." $loggingPrefix
Set-Location $currentDirectory