[CmdletBinding()]
param(
    $Settings,
    [String] $LoggingPrefix
)

    Write-EdenInfo "Building the Angular application." $LoggingPrefix
    Set-Location "./App"
    ng build
    Write-EdenInfo "Finished building the Angular application." $LoggingPrefix
