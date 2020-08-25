[CmdletBinding()]
param(
    $Settings,
    [String] $LoggingPrefix
)

    Write-EdenInfo "Starting the Angular application with ng serve." $LoggingPrefix
    Set-Location "./App"
    ng serve --open --port=4000 | Write-Verbose