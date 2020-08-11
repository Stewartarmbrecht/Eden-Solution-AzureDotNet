[CmdletBinding()]
param(
    $Settings,
    [String] $LoggingPrefix
)

    Write-EdenBuildInfo "Performing some action." $LoggingPrefix
    # Perform the action here.
    Write-EdenBuildInfo "Finished performing some action." $LoggingPrefix
