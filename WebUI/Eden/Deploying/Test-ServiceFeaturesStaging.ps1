[CmdletBinding()]
param(
    $Settings,
    [String] $LoggingPrefix
)

    Write-EdenInfo "Testing the Angular application at 'https://$($Settings.EnvironmentName)-webuiproxy-staging.azurewebsites.net/'." $LoggingPrefix
    Set-Location "./App"
    if ($VerbosePreference -eq "SilentlyContinue") {
        ng e2e --dev-server-target="" --base-url="https://$($Settings.EnvironmentName)-webuiproxy-staging.azurewebsites.net/" | Write-Verbose
    } else {
        ng e2e --dev-server-target="" --base-url="https://$($Settings.EnvironmentName)-webuiproxy-staging.azurewebsites.net/"
    }
    Write-EdenInfo "Finished testing the Angular application at 'https://$($Settings.EnvironmentName)-webuiproxy-staging.azurewebsites.net/'." $LoggingPrefix
