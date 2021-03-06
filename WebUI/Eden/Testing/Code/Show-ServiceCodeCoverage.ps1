[CmdletBinding()]
param(
    $Settings,
    [String] $LoggingPrefix
)

    Write-EdenInfo "Launching a browser to load the code coverage report at './App/testresults/coverage/index.html'." $LoggingPrefix

    Write-Host "" -ForegroundColor Blue
    Write-Host "Click: http://localhost:8089/index.html" -ForegroundColor Blue
    Write-Host "" -ForegroundColor Blue
    Set-Location "./App/testresults/coverage/"
    live-server --port=8089

