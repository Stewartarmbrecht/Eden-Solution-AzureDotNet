[CmdletBinding()]
param(
    $Settings,
    [String] $LoggingPrefix
)

    Write-EdenInfo "Testing the Angular application." $LoggingPrefix
    Set-Location "./Service"
    $verbosity = $VerbosePreference
    $VerbosePreference = "Continue"
    ng test --code-coverage | Write-Verbose
    $VerbosePreference = $verbosity
    Write-EdenInfo "Finished testing the Angular application." $LoggingPrefix
