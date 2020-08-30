[CmdletBinding()]
param(
    $Settings,
    [String] $LoggingPrefix
)

    Write-EdenInfo "Starting the Angular application with ng serve." $LoggingPrefix
    Set-Location "./App"
    if ($Settings.RemoteLiveReload.ToLower() -eq "true") {
        if ($VerbosePreference -eq "SilentlyContinue") {
            ng serve --open --port=4000 --host 0.0.0.0 | Write-Verbose
        } else {
            ng serve --open --port=4000 --host 0.0.0.0
        }    
    } else {
        if ($VerbosePreference -eq "SilentlyContinue") {
            ng serve --open --port=4000 | Write-Verbose
        } else {
            ng serve --open --port=4000
        }    
    }
    
