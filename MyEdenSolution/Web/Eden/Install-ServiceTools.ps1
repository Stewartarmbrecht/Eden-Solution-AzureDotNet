[CmdletBinding()]
param(
    $EdenEnvConfig,
    [String] $LoggingPrefix
)

    Write-EdenBuildInfo "Installing the Angular CLI." $LoggingPrefix 
    npm install -g @angular/cli
    $location = Get-Location
    Set-Location "./Service"
    npm update
    Set-Location $location
    Write-EdenBuildInfo "Finished installing the Angular CLI." $LoggingPrefix 

    Write-EdenBuildInfo "Installing Live Server to run a web server for accessing html files." $LoggingPrefix
    npm install -g live-server

    Write-EdenBuildInfo "Installing Markserve to use for serving up markdown documentation." $LoggingPrefix
    npm i -g markserv

