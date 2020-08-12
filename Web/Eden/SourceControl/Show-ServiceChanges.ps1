[CmdletBinding()]
param(
    $Settings,
    [String] $LoggingPrefix
)

    Write-EdenInfo "Getting changed files." $LoggingPrefix
    git diff --name-status
