[CmdletBinding()]
param(
    $EdenEnvConfig,
    [String] $LoggingPrefix
)

    Write-EdenBuildInfo "Skipping the deployment of Event Grid subscriptions as there are none for the Angular application." $LoggingPrefix
