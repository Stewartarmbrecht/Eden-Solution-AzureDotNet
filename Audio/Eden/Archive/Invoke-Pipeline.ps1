[CmdletBinding()]
param()
$currentDirectory = Get-Location
Set-Location $PSSCriptRoot

. ./Functions.ps1

./Configure-Environment.ps1

$instanceName = $Env:InstanceName

$loggingPrefix = "MyEdenSolution Audio Pipeline $instanceName"

Write-EdenInfo "Running the full pipeline for the microservice." $loggingPrefix

./Build-Application.ps1
./Test-Unit.ps1
./Test-Automated.ps1
./Build-DeploymentPackage.ps1
./Deploy-Service.ps1

Write-EdenInfo "Finished the full pipeline for the microservice." $loggingPrefix

Set-Location $currentDirectory