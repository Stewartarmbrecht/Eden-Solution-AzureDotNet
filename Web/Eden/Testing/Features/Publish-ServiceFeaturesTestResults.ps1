[CmdletBinding()]
param(
    $Settings,
    [String] $LoggingPrefix
)

    Write-EdenInfo "Publishing the features test results xml report." $LoggingPrefix
    Copy-Item "./Service/testresults/junit/e2e-test-result.xml" -Destination "./Reports/TestResults/Features.xml" -Force
    Write-EdenInfo "Finished publishing the feature test results xml report." $LoggingPrefix
