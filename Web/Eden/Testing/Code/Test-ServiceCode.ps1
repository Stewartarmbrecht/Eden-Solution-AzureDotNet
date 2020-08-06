[CmdletBinding()]
param(
    $Settings,
    [String] $LoggingPrefix
)

    Write-EdenBuildInfo "Testing the Angular application." $LoggingPrefix
    Set-Location "./Service"
    $verbosity = $VerbosePreference
    $VerbosePreference = "Continue"
    ng test --code-coverage --watch=false | Write-Verbose
    $VerbosePreference = $verbosity
    Write-EdenBuildInfo "Finished testing the Angular application." $LoggingPrefix
