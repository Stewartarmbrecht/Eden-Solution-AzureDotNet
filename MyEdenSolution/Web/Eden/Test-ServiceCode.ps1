[CmdletBinding()]
param(
    $EdenEnvConfig,
    [String] $LoggingPrefix
)

    Write-EdenBuildInfo "Testing the Angular application." $LoggingPrefix
    Set-Location "./Service"
    ng test | Write-Verbose
    Write-EdenBuildInfo "Finished testing the Angular application." $LoggingPrefix
