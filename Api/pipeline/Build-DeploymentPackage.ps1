[CmdletBinding()]
param(
)

$currentDirectory = Get-Location
Set-Location $PSScriptRoot

. ./Functions.ps1

$loggingPrefix = "MyEdenSolution Api Package"

$path =  "./../Service/**"
$destination = "./../.dist/app.zip"

Write-EdenInfo "Removing the API package." $loggingPrefix 
Remove-Item -Path $destination -Recurse -Force -ErrorAction Ignore

Write-EdenInfo "Creating the .dist folder." $loggingPrefix
$result = New-Item -Path "./../" -Name ".dist" -ItemType "directory" -Force
if($VerbosePreference -ne 'SilentlyContinue') { $result }

Write-EdenInfo "Creating the API package." $loggingPrefix
Compress-Archive -Path $path -DestinationPath $destination 

Write-EdenInfo "Finished building the Api package." $loggingPrefix

Set-Location $currentDirectory
