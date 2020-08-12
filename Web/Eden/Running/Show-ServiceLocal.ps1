[CmdletBinding()]
param(
    $Settings,
    [String] $LoggingPrefix
)

    Write-EdenInfo "Launching a browser to load the home page 'http://localhost:4000'." $LoggingPrefix

    Write-Host "" -ForegroundColor Blue
    Write-Host "Click: http://localhost:4000/" -ForegroundColor Blue
    Write-Host "" -ForegroundColor Blue
    start http://localhost:4000/

