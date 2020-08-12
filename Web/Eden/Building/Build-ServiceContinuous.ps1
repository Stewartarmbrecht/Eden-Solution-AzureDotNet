[CmdletBinding()]
param(
    $Settings,
    [String] $LoggingPrefix
)

    Write-EdenInfo "Building the Angular application with watch enabled." $LoggingPrefix
    Set-Location "./Service"
    ng build --watch=true
