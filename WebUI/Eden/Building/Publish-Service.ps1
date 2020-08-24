[CmdletBinding()]
param(
    $Settings,
    [String] $LoggingPrefix
)

Write-EdenInfo "Building the Angular application with the production flag." $LoggingPrefix
Set-Location "./App"
if ($VerbosePreference -eq "SilentlyContinue") {
    ng build --prod --outputPath=./../.dist/$($Settings.EnvironmentName)/App | Write-Verbose
} else {
    ng build --prod --outputPath=./../.dist/$($Settings.EnvironmentName)/App
}
Write-EdenInfo "Finished building the Angular application with the production flag." $LoggingPrefix

    
Set-Location "../"
$path =  "./Proxy/proxies.json"
$destinationFolder = "./.dist/$($Settings.EnvironmentName)/Proxy"

Write-EdenInfo "Removing the proxy function app package." $loggingPrefix 
$result = Remove-Item -Path "$destinationFolder/app.zip" -Recurse -Force -ErrorAction Ignore
if($VerbosePreference -ne 'SilentlyContinue') { $result }

Write-EdenInfo "Creating the proxy function app dist folder." $loggingPrefix
$result = New-Item -Path $destinationFolder -ItemType "directory" -Force
if($VerbosePreference -ne 'SilentlyContinue') { $result }

Write-EdenInfo "Creating the proxy function app package." $loggingPrefix
$result = Compress-Archive -Path $path -DestinationPath "$destinationFolder/app.zip" -Force
if($VerbosePreference -ne 'SilentlyContinue') { $result }

Write-EdenInfo "Finished building the proxy function app package." $loggingPrefix

Set-Location $currentDirectory
