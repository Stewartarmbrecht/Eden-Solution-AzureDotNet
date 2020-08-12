[CmdletBinding()]
param(
    [Parameter()]
    [switch]$Continuous
)

$currentDirectory = Get-Location
Set-Location $PSScriptRoot

. ./Functions.ps1

./Configure-Environment

$loggingPrefix = "MyEdenSolution Api Test End to End $instanceName"

Write-EdenInfo "This application does not have any automated tests yet.  Please add some!" $loggingPrefix

Set-Location $currentDirectory
