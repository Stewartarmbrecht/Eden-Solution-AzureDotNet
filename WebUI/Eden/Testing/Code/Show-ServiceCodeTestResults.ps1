[CmdletBinding()]
param(
    $Settings,
    [String] $LoggingPrefix
)

    Write-EdenInfo "Launching a browser to load the code coverage report at './App/testresults/html/index.html'." $LoggingPrefix

    Write-Host "" -ForegroundColor Blue
    Write-Host "Click: http://localhost:8090/index.html" -ForegroundColor Blue
    Write-Host "" -ForegroundColor Blue
    Set-Location "./App/testresults/html/"
    live-server --port=8090

