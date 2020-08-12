[CmdletBinding()]
param(
    $Settings,
    [String] $LoggingPrefix
)

    Write-EdenInfo "Launching visual studio code to the service directory." $LoggingPrefix
    code .
    Write-EdenInfo "Finished launching visual studio code to the service directory." $LoggingPrefix
