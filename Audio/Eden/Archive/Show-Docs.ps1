[CmdletBinding()]
param(
)

$currentDirectory = Get-Location
Set-Location $PSScriptRoot

. ./Functions.ps1

$loggingPrefix = "MyEdenSolution Start IDE"

Write-EdenInfo "Starting up the default development tool." $loggingPrefix

code ./../ ./../README.md -n

Set-Location $currentDirectory
