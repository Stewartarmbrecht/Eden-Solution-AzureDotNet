[CmdletBinding()]
param(
    $Settings,
    [String] $LoggingPrefix
)

    Write-EdenBuildInfo "Executing git add -A" $LoggingPrefix
    git add -A
