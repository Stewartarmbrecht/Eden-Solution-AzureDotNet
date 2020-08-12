[CmdletBinding()]
param(
    $Settings,
    [String] $LoggingPrefix
)

    Write-EdenInfo "Publishing the code coverage report." $LoggingPrefix
    Copy-Item "./Service/testresults/coverage/lcov.info" -Destination "./Reports/Coverage" -Recurse -Force
    Write-EdenInfo "Finished publishing the code coverage report." $LoggingPrefix
