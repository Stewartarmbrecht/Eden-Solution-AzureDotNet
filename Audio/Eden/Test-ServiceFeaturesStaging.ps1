[CmdletBinding()]
param(
    $Settings,
    [String] $LoggingPrefix
)

$apiName = "$($Settings.EnvironmentName)-audio".ToLower()
Write-EdenInfo "Setting the target url for the features test to: 'https://$apiName-staging.azurewebsites.net/api/audio'." $LoggingPrefix
$Env:FeaturesUrl = "https://$apiName-staging.azurewebsites.net/api/audio"

Write-EdenInfo "Running the tests in the Serivce.Tests/MyEdenSolution.Audio.Service.Tests.csproj project that are tagged as Features." $LoggingPrefix
dotnet test ./Service.Tests/MyEdenSolution.Audio.Service.Tests.csproj --filter TestCategory=Features
