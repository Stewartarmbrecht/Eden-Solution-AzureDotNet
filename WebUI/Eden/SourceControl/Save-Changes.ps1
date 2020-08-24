[CmdletBinding()]
param(
    $Settings,
    [String] $LoggingPrefix
)

    Write-EdenInfo "Executing git add -A" $LoggingPrefix
    git add -A
