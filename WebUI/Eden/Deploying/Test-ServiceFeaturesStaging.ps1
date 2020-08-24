[CmdletBinding()]
param(
    $Settings,
    [String] $LoggingPrefix
)

    Write-EdenInfo "Testing the Angular application." $LoggingPrefix
    Set-Location "./App"
    if ($VerbosePreference -eq "SilentlyContinue") {
        npm run e2e | Write-Verbose
    } else {
        npm run e2e
    }
    Write-EdenInfo "Finished testing the Angular application." $LoggingPrefix
