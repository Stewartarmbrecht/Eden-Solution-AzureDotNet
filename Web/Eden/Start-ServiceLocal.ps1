[CmdletBinding()]
param(
    $EdenEnvConfig,
    [String] $LoggingPrefix
)

    Write-EdenBuildInfo "Starting the Angular application with ng serve." $LoggingPrefix
    Set-Location "./Service"
    ng serve --open --port=4001 | Write-Verbose
