[CmdletBinding()]
param(
    $Settings,
    [String] $LoggingPrefix
)

    Write-EdenBuildInfo "Launching visual studio code to the service directory." $LoggingPrefix
    code .
    Write-EdenBuildInfo "Finished launching visual studio code to the service directory." $LoggingPrefix
