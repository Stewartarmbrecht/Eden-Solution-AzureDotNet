[CmdletBinding()]
param(
    $Settings,
    [String] $LoggingPrefix
)

    Write-EdenInfo "Testing the Angular application." $LoggingPrefix
    Set-Location "./App"
    $verbosity = $VerbosePreference
    $VerbosePreference = "Continue"
    npm run e2e | Write-Verbose
    $VerbosePreference = $verbosity
    Write-EdenInfo "Finished testing the Angular application." $LoggingPrefix
