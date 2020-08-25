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
            ./ngrok.exe http http://localhost:4000 -host-header=rewrite | Write-Verbose
        } 
        if ($IsMacOS) {
            Set-Location $PSScriptRoot/Mac
            ./ngrok http http://localhost:4000 -host-header=rewrite | Write-Verbose
        }
        if ($IsLinux) {
            Set-Location $PSScriptRoot/Linux
            & ./ngrok http http://localhost:4000 -host-header=rewrite | Write-Verbose
        }
    } catch {
        throw $_
    } finally {
        Set-Location $location
    }