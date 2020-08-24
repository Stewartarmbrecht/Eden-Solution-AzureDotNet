[CmdletBinding()]
param(
    $Settings,
    [String] $LoggingPrefix
)

    Write-EdenInfo "Publishing the code test results xml report." $LoggingPrefix
    Copy-Item "./App/testresults/junit/*" -Destination "./Reports/TestResults/Code.xml" -Force
    Write-EdenInfo "Finished publishing the code test results xml report." $LoggingPrefix
