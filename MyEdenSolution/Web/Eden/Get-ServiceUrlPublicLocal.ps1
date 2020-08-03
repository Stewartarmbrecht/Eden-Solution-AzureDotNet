[CmdletBinding()]
param(
    $EdenEnvConfig,
    [String] $LoggingPrefix
)
try {
    Write-EdenBuildInfo "Returning private URL as public URL is not necessary for the local instance." $LoggingPrefix
    return "http://localhost:4001"
}
catch {
    $message = $_.Exception.Message
    Write-EdenBuildError "Failed to get the public url: '$message'." $loggingPrefix
    return ""
}
