[CmdletBinding()]
param(
    $Settings,
    [String] $LoggingPrefix
)

    Write-EdenInfo "Publishing the code test results xml report." $LoggingPrefix
    Copy-Item "./Service/testresults/junit/*" -Destination "./Reports/TestResults/Results.xml" -Force
    Write-EdenInfo "Finished publishing the code test results xml report." $LoggingPrefix
