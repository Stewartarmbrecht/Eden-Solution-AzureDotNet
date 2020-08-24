[CmdletBinding()]
param(
    $Settings,
    [String] $LoggingPrefix
)

    Write-EdenInfo "Testing the Angular application." $LoggingPrefix
    Set-Location "./App"
    if ($VerbosePreference -eq "SilentlyContinue") {
        ng test --code-coverage --watch=false | Write-Verbose
    } else {
        ng test --code-coverage --watch=false
    }
    Write-EdenInfo "Finished testing the Angular application." $LoggingPrefix
