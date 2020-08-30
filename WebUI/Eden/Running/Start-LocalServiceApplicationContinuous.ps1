[CmdletBinding()]
param(
    $Settings,
    [String] $LoggingPrefix
)

Write-EdenInfo "Starting the Angular application with ng serve and --watch=true." $LoggingPrefix
Set-Location "./App"
ng serve --open --watch=true --port=4000

