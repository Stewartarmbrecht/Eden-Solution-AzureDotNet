[CmdletBinding()]
param(
    $Settings,
    [String] $LoggingPrefix
)

    Write-EdenBuildInfo "Publishing the code coverage report." $LoggingPrefix
    Copy-Item "./Service/testresults/coverage/lcov.info" -Destination "./Reports/Coverage" -Recurse -Force
    Write-EdenBuildInfo "Finished publishing the code coverage report." $LoggingPrefix
