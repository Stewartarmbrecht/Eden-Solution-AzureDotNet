[CmdletBinding()]
param(
    $Settings,
    [String] $LoggingPrefix
)

    Write-EdenInfo "Launching a browser to load the features test results report at './App/testresults/e2e/report.html'." $LoggingPrefix

    Write-Host "" -ForegroundColor Blue
    Write-Host "Click: http://localhost:8091/report.html" -ForegroundColor Blue
    Write-Host "" -ForegroundColor Blue
    Set-Location "./App/testresults/e2e/"
    live-server --port=8091 --open=report.html

