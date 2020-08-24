[CmdletBinding()]
param(
    $Settings,
    [String] $LoggingPrefix
)
try {
    Write-EdenInfo "Calling service health check at 'http://localhost:4001/api/healthcheck?userId=developer98765@test.com'." $LoggingPrefix
    $response = Invoke-RestMethod -URI "http://localhost:4001/api/healthcheck?userId=developer98765@test.com"
    Write-Host ""
    Write-Host $response -ForegroundColor Blue
    Write-Host ""
} catch {
    $message = $_.Exception.Message
    Write-Host ""
    Write-EdenError "Failed to execute health check: '$message'." $LoggingPrefix
    Write-Host ""
}
