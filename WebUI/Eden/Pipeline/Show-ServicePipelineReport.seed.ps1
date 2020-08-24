[CmdletBinding()]
param(
    $Settings,
    [String] $LoggingPrefix
)

    Write-EdenInfo "Performing some action." $LoggingPrefix
    # Perform the action here.
    Write-EdenInfo "Finished performing some action." $LoggingPrefix
