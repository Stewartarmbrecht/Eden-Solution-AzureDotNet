[CmdletBinding()]
param(
    $Settings,
    [String] $LoggingPrefix
)

    Write-EdenInfo "Skipping the deployment of Event Grid subscriptions as there are none for the Angular application." $LoggingPrefix
