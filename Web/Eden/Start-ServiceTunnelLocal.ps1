[CmdletBinding()]
param(
    $EdenEnvConfig,
    [String] $LoggingPrefix
)

    Write-EdenBuildInfo "Skipping the creation of a tunnel to the local web ui as it is not needed." $LoggingPrefix
    while ($True) {}
