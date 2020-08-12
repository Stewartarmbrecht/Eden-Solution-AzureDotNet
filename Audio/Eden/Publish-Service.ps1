[CmdletBinding()]
param(
    $Settings,
    [String] $LoggingPrefix
)

Write-EdenInfo "Publishing the function application to './.dist/app'." $LoggingPrefix
dotnet publish ./Service/MyEdenSolution.Audio.Service.csproj -c Release -o ./.dist/app

$appPath =  "./.dist/app/**"
$appDestination = "./.dist/app.zip"

Write-EdenInfo "Removing the app package: './.dist/app.zip'." $LoggingPrefix
Remove-Item -Path $appDestination -Recurse -Force -ErrorAction Ignore

Write-EdenInfo "Creating the app package: './.dist/app.zip'." $LoggingPrefix
Compress-Archive -Path $appPath -DestinationPath $appDestination