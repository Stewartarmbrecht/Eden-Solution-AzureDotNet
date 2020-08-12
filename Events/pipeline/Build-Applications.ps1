[CmdletBinding()]
param(
)

$currentDirectory = Get-Location
Set-Location $PSScriptRoot

. ./Functions.ps1

$loggingPrefix = "MyEdenSolution Events Build"

Invoke-BuildCommand "dotnet build ./../MyEdenSolution.Events.sln" $loggingPrefix "Building the solution."

Write-EdenInfo "Finished building the solution." $loggingPrefix

Set-Location $currentDirectory
