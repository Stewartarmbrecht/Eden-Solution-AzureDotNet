[CmdletBinding()]
param(
    $Settings,
    [String] $LoggingPrefix,
    [String] $Url
)
try {
    Write-EdenInfo "Calling service health check at '$Url'." $LoggingPrefix
    $response = Invoke-WebRequest -URI $Url
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
    Write-EdenInfo "Failed to get health check status: '$message'." $LoggingPrefix
    return $FALSE
}