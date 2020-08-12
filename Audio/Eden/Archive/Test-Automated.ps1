[CmdletBinding()]
param(
    [Parameter()]
    [switch]$Continuous
)

$currentDirectory = Get-Location
Set-Location $PSScriptRoot

. ./Functions.ps1

./Configure-Environment

$loggingPrefix = "MyEdenSolution Audio Test End to End $instanceName"

if ($Continuous) {
    Write-EdenInfo "Running automated tests continuously." $loggingPrefix
    ./Start-Local.ps1 -RunAutomatedTestsContinuously -Verbose
} else {
    Write-EdenInfo "Running automated tests." $loggingPrefix
    ./Start-Local.ps1 -RunAutomatedTests
}

Set-Location $currentDirectory
