[CmdletBinding()]
param(
    $Settings,
    [String] $LoggingPrefix
)

    Write-EdenInfo "Publishing the security test results afr report." $LoggingPrefix
    Copy-Item "./App/testresults/security/results.afr" -Destination "./Reports/TestResults/Security.afr" -Force
    Write-EdenInfo "Finished publishing the security test results afr report." $LoggingPrefix
