[CmdletBinding()]
param(
    $Settings,
    [String] $LoggingPrefix
)

    Write-EdenInfo "Publishing the performance test results xml report." $LoggingPrefix
    Copy-Item "./Performance/TestResults.json" -Destination "./Reports/TestResults/Performance.json" -Force
    Write-EdenInfo "Finished publishing the performance test results xml report." $LoggingPrefix
