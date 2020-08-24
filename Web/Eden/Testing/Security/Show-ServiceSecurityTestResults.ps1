[CmdletBinding()]
param(
    $Settings,
    [String] $LoggingPrefix
)

    Write-EdenInfo "Launching a browser to load the security report at './App/testresults/security/index.html'." $LoggingPrefix

    Write-Host "" -ForegroundColor Blue
    Write-Host "Click: http://localhost:8093/index.html" -ForegroundColor Blue
    Write-Host "" -ForegroundColor Blue
    Set-Location "./App/testresults/security/"
    live-server --port=8093 --open=index.html

