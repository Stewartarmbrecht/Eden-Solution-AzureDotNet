[CmdletBinding()]
param(
    $Settings,
    [String] $LoggingPrefix
)
try {
    Write-EdenInfo "Calling service health check at 'http://localhost:4000/'." $LoggingPrefix
    $response = Invoke-WebRequest -URI "http://localhost:4000/"
    $status = $response.StatusCode -eq 200
    if($status) {
        Write-EdenInfo "Health check status successful." $LoggingPrefix
        return $TRUE
    } else {
        Write-EdenInfo "Health check status unsuccessful. Status: $status" $LoggingPrefix
        return $FALSE
    }
} catch {
    $message = $_.Exception.Message
    Write-EdenError "Failed to get health check status: '$message'." $LoggingPrefix
    return $FALSE
}