[CmdletBinding()]
param()

$currentDirectory = Get-Location
Set-Location $PSScriptRoot

. ./Functions.ps1

./Configure-Environment.ps1

$instanceName = $Env:InstanceName

$loggingPrefix = "MyEdenSolution Api Deploy Service $instanceName"

Write-EdenInfo "Deploying the service." $loggingPrefix

./Deploy-Infrastructure.ps1

./Deploy-Application.ps1

#./Deploy-Subscription.ps1

Write-EdenInfo "Deployed the service." $loggingPrefix

Set-Location $currentDirectory