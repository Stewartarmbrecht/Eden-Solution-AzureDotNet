[CmdletBinding()]
param(
    $Settings,
    [String] $LoggingPrefix
)

    $url = "https://$($Settings.EnvironmentName)-webuiproxy.azurewebsites.net"

    Write-EdenInfo "Testing the performance of the service at: '$url'." $LoggingPrefix
    if ($VerbosePreference -eq "SilentlyContinue") {
        k6 run -e URL=$url --summary-export=./Performance/TestResults.json ./Performance/main.js | Write-Verbose
    } else {
        k6 run -e URL=$url --summary-export=./Performance/TestResults.json ./Performance/main.js
    }
    Write-EdenInfo "Finished testing the performance of the service at: '$url'." $LoggingPrefix
