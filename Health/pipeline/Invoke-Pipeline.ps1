[CmdletBinding()]
param()

$solutionName = "MyEdenSolution"
$serviceName = "Health"

try {
    $currentDirectory = Get-Location
    Set-Location $PSSCriptRoot

    . ./Functions.ps1

    ./Configure-Environment.ps1 -Check

    $instanceName = $Env:InstanceName

    $loggingPrefix = "$solutionName $serviceName Pipeline $instanceName"

    Write-EdenInfo "Running the full pipeline for the service." $loggingPrefix

    ./Build-Application.ps1
    ./Test-Unit.ps1
    ./Test-Automated.ps1
    ./Build-DeploymentPackage.ps1
    ./Deploy-Service.ps1

    Write-EdenInfo "Finished the full pipeline for the service." $loggingPrefix

    Set-Location $currentDirectory
}
catch
{
    Set-Location $currentDirectory
    throw $_
}