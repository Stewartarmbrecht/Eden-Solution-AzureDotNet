[CmdletBinding()]
param(
    $Settings,
    [String] $LoggingPrefix
)

    Write-EdenBuildInfo "Publishing the code test results xml report." $LoggingPrefix
    Copy-Item "./Service/testresults/junit/*" -Destination "./Reports/TestResults/Results.xml" -Force
    Write-EdenBuildInfo "Finished publishing the code test results xml report." $LoggingPrefix
