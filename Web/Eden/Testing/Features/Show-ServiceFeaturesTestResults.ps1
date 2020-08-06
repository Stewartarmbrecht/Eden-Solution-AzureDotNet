[CmdletBinding()]
param(
    $Settings,
    [String] $LoggingPrefix
)

    Write-EdenBuildInfo "Launching a browser to load the code coverage report at './Service/testresults/e2e/report.html'." $LoggingPrefix

    Write-Host "" -ForegroundColor Blue
    Write-Host "Click: http://localhost:8091/report.html" -ForegroundColor Blue
    Write-Host "" -ForegroundColor Blue
    Set-Location "./Service/testresults/e2e/"
    live-server --port=8091 --open=report.html

