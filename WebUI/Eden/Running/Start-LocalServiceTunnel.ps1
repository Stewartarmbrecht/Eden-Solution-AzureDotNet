[CmdletBinding()]
param(
    $Settings,
    [String] $LoggingPrefix
)

    Write-EdenInfo "Starting the ngrok local tunnel to the function application.  Private url: 'http://localhost:4000'." $LoggingPrefix

    $location = Get-Location
    try {
        if ($IsWindows) {
            Set-Location $PSScriptRoot/Windows
            if ($VerbosePreference -eq "SilentlyContinue") {
                ./ngrok.exe http http://localhost:4000 -host-header=rewrite | Write-Verbose
            } else {
                ./ngrok.exe http http://localhost:4000 -host-header=rewrite
            }
        } 
        if ($IsMacOS) {
            Set-Location $PSScriptRoot/Mac
            if ($VerbosePreference -eq "SilentlyContinue") {
                ./ngrok http http://localhost:4000 -host-header=rewrite | Write-Verbose
            } else {
                ./ngrok http http://localhost:4000 -host-header=rewrite
            }
        }
        if ($IsLinux) {
            Set-Location $PSScriptRoot/Linux
            if ($VerbosePreference -eq "SilentlyContinue") {
                & ./ngrok http http://localhost:4000 -host-header=rewrite | Write-Verbose
            } else {
                & ./ngrok http http://localhost:4000 -host-header=rewrite
            }
        }
    } catch {
        throw $_
    } finally {
        Set-Location $location
    }
