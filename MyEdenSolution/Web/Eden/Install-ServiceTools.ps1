[CmdletBinding()]
param(
    $EdenEnvConfig,
    [String] $LoggingPrefix
)

    Write-EdenBuildInfo "Installing the Angular CLI." $LoggingPrefix 
    npm install -g @angular/cli
    Write-EdenBuildInfo "Finished installing the Angular CLI." $LoggingPrefix 
