[CmdletBinding()]
param(
    $Settings,
    [String] $LoggingPrefix
)

    Write-EdenBuildInfo "Building the Angular application with the production flag." $LoggingPrefix
    Set-Location "./Service"
    ng build --prod
    Write-EdenBuildInfo "Finished building the Angular application with the production flag." $LoggingPrefix
