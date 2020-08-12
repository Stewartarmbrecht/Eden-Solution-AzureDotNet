[CmdletBinding()]
param(
    [switch] $Dev
)
$currentDirectory = Get-Location
Set-Location $PSSCriptRoot

. ./Functions.ps1

./Configure-Environment.ps1

$instanceName = $Env:InstanceName

$loggingPrefix = "MyEdenSolution API Pipeline $instanceName"

Write-EdenInfo "Running the full pipeline for the events subsystem." $loggingPrefix

./Build-DeploymentPackage.ps1
./Deploy-Service.ps1

Write-EdenInfo "Finished the full pipeline for the API subsystem." $loggingPrefix

Set-Location $currentDirectory