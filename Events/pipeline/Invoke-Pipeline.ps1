[CmdletBinding()]
param(
    [switch] $Dev
)
$currentDirectory = Get-Location
Set-Location $PSSCriptRoot

. ./Functions.ps1

./Configure-Environment.ps1

$instanceName = $Env:InstanceName

$loggingPrefix = "MyEdenSolution Events Pipeline $instanceName"

Write-EdenInfo "Running the full pipeline for the events subsystem." $loggingPrefix

./Build-Applications.ps1
./Test-Unit.ps1
./Deploy-Infrastructure.ps1

Write-EdenInfo "Finished the full pipeline for the events subsystem." $loggingPrefix

Set-Location $currentDirectory