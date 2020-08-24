[CmdletBinding()]
param(
    $Settings,
    [String] $LoggingPrefix
)

    Write-EdenInfo "Launching a browser to load the published features test results report at './Reports/TestResults/Features.xml'." $LoggingPrefix

    Write-Host "" -ForegroundColor Blue
    Write-Host "Click: http://localhost:8090/Features.xml" -ForegroundColor Blue
    Write-Host "" -ForegroundColor Blue
    Set-Location "./Reports/TestResults/"
    live-server --port=8090 --open=Features.xml

