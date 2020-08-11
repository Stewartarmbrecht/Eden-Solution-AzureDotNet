[CmdletBinding()]
param(
    $Settings,
    [String] $LoggingPrefix
)

    Write-EdenBuildInfo "Getting changed files." $LoggingPrefix
    git diff --name-status
