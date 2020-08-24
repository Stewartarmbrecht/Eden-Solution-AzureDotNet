[CmdletBinding()]
param(
    $Settings,
    [String] $LoggingPrefix,
    [Alias("m")]
    [Parameter(Mandatory=$true)]
    [String] $Message
)

    Write-EdenInfo "Committing the staged changes." $LoggingPrefix
    git commit -am "$Message"
