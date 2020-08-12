[CmdletBinding()]
param(
    $Settings,
    [String] $LoggingPrefix
)
try {
    Write-EdenInfo "Calling service health check at 'http://localhost:7071/api/healthcheck?userId=developer98765@test.com'." $LoggingPrefix
    $response = Invoke-RestMethod -URI "http://localhost:7071/api/healthcheck?userId=developer98765@test.com"
    $status = $response.status
    if($status -eq 0) {
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