[CmdletBinding()]
param(
    $Settings,
    [String] $LoggingPrefix
)

    Write-EdenBuildInfo "Nothing to install.  Use git which is a standard Eden tool." $LoggingPrefix