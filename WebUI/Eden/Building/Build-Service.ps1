[CmdletBinding()]
param(
    $Settings,
    [String] $LoggingPrefix
)

    Write-EdenInfo "Building the Angular application." $LoggingPrefix
    Set-Location "./App"
    if ($VerbosePreference -eq "SilentlyContinue") {
        ng build | Write-Verbose
    } else {
        ng build
    }
    if($LASTEXITCODE -ne 0) {
        throw "Build failed. See output for error information."
    }
    Write-EdenInfo "Finished building the Angular application." $LoggingPrefix
