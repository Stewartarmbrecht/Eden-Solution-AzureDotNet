[CmdletBinding()]
param(
    $EdenEnvConfig,
    [String] $LoggingPrefix
)

    Write-EdenBuildInfo "Building the Angular application with watch enabled." $LoggingPrefix
    Set-Location "./Service"
    ng build --watch=true
