[CmdletBinding()]
param(
    $Settings,
    [String] $LoggingPrefix
)

    Write-EdenError "Angular does not support running e2e tests continuously." $LoggingPrefix
    Write-EdenError "See: https://github.com/angular/angular-cli/issues/2861" $LoggingPrefix
