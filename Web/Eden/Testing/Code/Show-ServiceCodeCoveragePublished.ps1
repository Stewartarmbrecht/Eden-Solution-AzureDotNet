[CmdletBinding()]
param(
    $Settings,
    [String] $LoggingPrefix
)

    Write-EdenBuildInfo "Launching a browser to load the code coverage report at './Reports/Coverage/'." $LoggingPrefix

    Write-Host "" -ForegroundColor Blue
    Write-Host "Click: http://localhost:8089/" -ForegroundColor Blue
    Write-Host "" -ForegroundColor Blue
    Set-Location "./Reports/Coverage/"
    live-server --port=8089

