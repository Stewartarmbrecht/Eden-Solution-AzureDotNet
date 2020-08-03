[CmdletBinding()]
param(
    $EdenEnvConfig,
    [String] $LoggingPrefix
)
try {
    Write-EdenBuildInfo "Calling service health check at 'http://localhost:4001/'." $LoggingPrefix
    $response = Invoke-WebRequest -URI "http://localhost:4001/"
    $status = $response.StatusCode -eq 200
    if($status) {
        Write-EdenBuildInfo "Health check status successful." $LoggingPrefix
        return $TRUE
    } else {
        Write-EdenBuildInfo "Health check status unsuccessful. Status: $status" $LoggingPrefix
        return $FALSE
    }
} catch {
    $message = $_.Exception.Message
    Write-EdenBuildError "Failed to get health check status: '$message'." $LoggingPrefix
    return $FALSE
}