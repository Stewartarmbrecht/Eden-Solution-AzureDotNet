[CmdletBinding()]
param(
    $Settings,
    [String] $LoggingPrefix
)

    Write-EdenInfo "Publishing code coverage reports to './Service.Tests/Reports/Coverage'" $LoggingPrefix
    reportgenerator "-reports:./Service.Tests/TestResults/Coverage.info" "-targetdir:Service.Tests/Reports/Coverage" -reporttypes:Html
    Write-EdenInfo "Finished publishing code coverage reports to './Service.Tests/Reports/Coverage'" $LoggingPrefix   