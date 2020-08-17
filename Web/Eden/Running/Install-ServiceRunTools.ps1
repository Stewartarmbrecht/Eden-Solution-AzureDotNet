[CmdletBinding()]
param(
    $Settings,
    [String] $LoggingPrefix
)

Write-EdenError "Need to update to install ngrok instead of using source control to store executable file." $LoggingPrefix