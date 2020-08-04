[CmdletBinding()]
param(
    $EdenEnvConfig,
    [String] $LoggingPrefix
)

Write-EdenBuildInfo "Starting the Angular application with ng serve and --watch=true." $LoggingPrefix
Set-Location "./Service"
ng serve --open --watch=true --port=4001 | Write-Verbose
