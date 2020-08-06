[CmdletBinding()]
param(
    [String] $LoggingPrefix
)

Write-EdenBuildInfo "Installing the Angular CLI." $LoggingPrefix 
npm install -g @angular/cli
$location = Get-Location
Set-Location "./Service"
npm update
Set-Location $location
Write-EdenBuildInfo "Finished installing the Angular CLI." $LoggingPrefix 
