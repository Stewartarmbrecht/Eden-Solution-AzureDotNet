[CmdletBinding()]
param(
)

$currentDirectory = Get-Location
Set-Location $PSScriptRoot

. ./Functions.ps1

$loggingPrefix = "MyEdenSolution Start IDE"

Write-EdenBuildInfo "Starting up the default development tool." $loggingPrefix

Set-Location ../

code .

Set-Location $currentDirectory
