[CmdletBinding()]
param(
    $Settings,
    [String] $LoggingPrefix
)

Write-EdenInfo "Syncing the local repo with the remote origin repo." $LoggingPrefix
Write-EdenInfo "Pulling changes from the remote origin master." $LoggingPrefix
git pull --tags origin master
Write-EdenInfo "Pushing changes to the remote origin master." $LoggingPrefix
git push origin master:master
Write-EdenInfo "Finished syncing the local with the remote origin repo." $LoggingPrefix
