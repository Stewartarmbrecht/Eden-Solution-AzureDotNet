[CmdletBinding()]
param(
    $Settings,
    [String] $LoggingPrefix
)

    Write-EdenBuildInfo "Launching a browser to load the code coverage report at './Reports/TestResults/Results.xml'." $LoggingPrefix

    Write-Host "" -ForegroundColor Blue
    Write-Host "Click: http://localhost:8090/Results.xml" -ForegroundColor Blue
    Write-Host "" -ForegroundColor Blue
    Set-Location "./Reports/TestResults/"
    live-server --port=8090 --open=Results.xml

