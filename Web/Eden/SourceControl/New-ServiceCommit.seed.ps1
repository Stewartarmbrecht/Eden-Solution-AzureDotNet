[CmdletBinding()]
param(
    [Alias("m")]
    [Parameter(Mandatory=$true)]
    [String] $Message,
    [Alias("a")]
    [Swtich] $All,
    [Alias("am")]
    [Switch] $AllMessage,
    [String] $LoggingPrefix
)

    Write-EdenBuildInfo "Committing the staged changes." $LoggingPrefix
    if ($AllMessage) {
        git commit -am "$Message"
    } elseif ($All) {
        git commit -a -m "$Message"
    } else {
        git commit -m "$Message"
    }
