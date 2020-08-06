[CmdletBinding()]
param(
    $Settings,
    [String] $LoggingPrefix
)

    Write-EdenBuildInfo "Publishing the code test results xml report." $LoggingPrefix
    Copy-Item "./Service/testresults/junit/e2e-test-result.xml" -Destination "./Reports/TestResults/Features.xml" -Force
    Write-EdenBuildInfo "Finished publishing the code test results xml report." $LoggingPrefix
