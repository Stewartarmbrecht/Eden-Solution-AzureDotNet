[CmdletBinding()]
param(
    $Settings,
    [String] $LoggingPrefix
)

    Write-EdenBuildInfo "Building the Angular application." $LoggingPrefix
    Set-Location "./Service"
    ng build
    Write-EdenBuildInfo "Finished building the Angular application." $LoggingPrefix
