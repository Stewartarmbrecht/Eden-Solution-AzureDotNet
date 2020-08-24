[CmdletBinding()]
param(
    $Settings,
    [String] $LoggingPrefix
)

    Write-EdenInfo "Testing the Angular application." $LoggingPrefix
    Set-Location "./App"
    $verbosity = $VerbosePreference
    $VerbosePreference = "Continue"
    ng test --code-coverage --watch=false | Write-Verbose
    $VerbosePreference = $verbosity
    Write-EdenInfo "Finished testing the Angular application." $LoggingPrefix
