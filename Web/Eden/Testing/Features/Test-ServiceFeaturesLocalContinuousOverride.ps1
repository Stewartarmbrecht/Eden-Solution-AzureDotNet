[CmdletBinding()]
param(
    $Settings,
    [String] $LoggingPrefix
)

    Write-EdenBuildError "Angular does not support running e2e tests continuously." $LoggingPrefix
    Write-EdenBuildError "See: https://github.com/angular/angular-cli/issues/2861" $LoggingPrefix
