[CmdletBinding()]
param(
    $Settings,
    [String] $LoggingPrefix
)

    Write-EdenInfo "Performing some action." $LoggingPrefix
    Build-EdenService -SettingsName $Settings.Name
    Test-EdenServiceCode -SettingsName $Settings.Name
    Test-EdenServiceFeatures -SettingsName $Settings.Name
    Publish-EdenService -SettingsName $Settings.Name
    Deploy-EdenServiceInfrastruction -SettingsName $Settings.Name
    Deploy-EdenServiceApplication -SettingsName $Settings.Name
    Write-EdenInfo "Finished performing some action." $LoggingPrefix
