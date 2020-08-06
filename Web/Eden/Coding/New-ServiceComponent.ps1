[CmdletBinding()]
param(
    [String] $Name,
    [String] $ServiceName,
    [String] $SolutionName,
    [String] $Type,
    [String] $LoggingPrefix
)

Write-Host "$LoggingPrefix $Name $SolutionName $ServiceName $Type"