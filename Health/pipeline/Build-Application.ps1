[CmdletBinding()]
param(
    [switch]$Continuous
)

$solutionName = "MyEdenSolution"
$serviceName = "Health"

. ./Functions.ps1

$currentDirectory = Get-Location
try {
    Set-Location $PSScriptRoot

    $loggingPrefix = "$solutionName $serviceName Build"
    
    #cdSet-Location "./../"
    if ($Continuous) {
        $command = "dotnet watch --project ./../$solutionName.$serviceName.sln build ./$solutionName.$serviceName.sln"
        $message = "Building the solution continuously."
    } else {
        $command = "dotnet build ./../$solutionName.$serviceName.sln"
        $message = "Building the solution."
    }
    
    Invoke-BuildCommand $command $message $loggingPrefix 

    Write-EdenInfo "Finished building the solution." $loggingPrefix

    Set-Location $currentDirectory
}
catch
{
    Set-Location $currentDirectory
    throw
}