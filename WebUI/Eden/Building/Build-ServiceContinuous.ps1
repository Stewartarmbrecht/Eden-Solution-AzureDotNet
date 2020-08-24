[CmdletBinding()]
param(
    $Settings,
    [String] $LoggingPrefix
)

    Write-EdenInfo "Building the Angular application with watch enabled." $LoggingPrefix
    Set-Location "./App"
    ng build --watch=true
