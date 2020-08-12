[CmdletBinding()]
param(
    $Settings,
    [String] $LoggingPrefix
)
try {
    Write-EdenInfo "Returning private URL as public URL is not necessary for the local instance." $LoggingPrefix
    return "http://localhost:4000"
}
catch {
    $message = $_.Exception.Message
    Write-EdenError "Failed to get the public url: '$message'." $loggingPrefix
    return ""
}
