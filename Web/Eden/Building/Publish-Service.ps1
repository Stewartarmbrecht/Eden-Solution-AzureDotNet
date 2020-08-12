[CmdletBinding()]
param(
    $Settings,
    [String] $LoggingPrefix
)

    Write-EdenInfo "Building the Angular application with the production flag." $LoggingPrefix
    Set-Location "./Service"
    ng build --prod
    Write-EdenInfo "Finished building the Angular application with the production flag." $LoggingPrefix
