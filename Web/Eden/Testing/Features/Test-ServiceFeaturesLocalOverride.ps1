[CmdletBinding()]
param(
    $Settings,
    [String] $LoggingPrefix
)

    Write-EdenBuildInfo "Testing the Angular application." $LoggingPrefix
    Set-Location "./Service"
    $verbosity = $VerbosePreference
    $VerbosePreference = "Continue"
    npm run e2e | Write-Verbose
    $VerbosePreference = $verbosity
    Write-EdenBuildInfo "Finished testing the Angular application." $LoggingPrefix
