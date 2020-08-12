[CmdletBinding()]
param(  
)
$currentDirectory = Get-Location
Set-Location $PSScriptRoot

. ./Functions.ps1

$loggingPrefix = "MyEdenSolution Audio Package"

Set-Location "$PSSCriptRoot/../"

$directoryStart = Get-Location

Write-EdenInfo "Packaging the service application." $loggingPrefix

Set-Location "$directoryStart/Service"
Invoke-BuildCommand "dotnet publish -c Release -o $directoryStart/.dist/app" $loggingPrefix "Publishing the function application."

$appPath =  "$directoryStart/.dist/app/**"
$appDestination = "$directoryStart/.dist/app.zip"

Write-EdenInfo "Removing the app package." $loggingPrefix
Remove-Item -Path $appDestination -Recurse -Force -ErrorAction Ignore

Write-EdenInfo "Creating the app package." $loggingPrefix
Compress-Archive -Path $appPath -DestinationPath $appDestination

Write-EdenInfo "Packaged the oservice." $loggingPrefix
Set-Location $currentDirectory
