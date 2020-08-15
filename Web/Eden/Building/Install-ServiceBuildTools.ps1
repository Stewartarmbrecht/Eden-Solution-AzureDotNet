[CmdletBinding()]
param(
    $Settings,
    [String] $LoggingPrefix
)

Write-EdenInfo "Installing the Angular CLI." $LoggingPrefix 
npm install -g @angular/cli
$location = Get-Location
Set-Location "./Service"
npm update
Set-Location $location
Write-EdenInfo "Finished installing the Angular CLI." $LoggingPrefix 
