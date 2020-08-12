[CmdletBinding()]
param(
    $Settings,
    [String] $LoggingPrefix
)

    Write-EdenInfo "Removing test results Allure history folder." $LoggingPrefix
    Remove-Item "./Service.Tests/TestResults/history" -Recurse
    Write-EdenInfo "Finished removing test results Allure history folder." $LoggingPrefix

    Write-EdenInfo "Copying published test results Allure history." $LoggingPrefix
    Copy-Item -Path "./Service.Tests/Reports/Results/history" -Destination "./Service.Tests/TestResults/history" -Recurse -Force
    Write-EdenInfo "Finished copying published test results Allure history." $LoggingPrefix

    Write-EdenInfo "Generating test results report to './Service.Tests/Reports/Results'" $LoggingPrefix
    allure generate ./Service.Tests/TestResults/ -o ./Service.Tests/Reports/Results --clean
    Write-EdenInfo "Finished generating test results report to './Service.Tests/Reports/Results'" $LoggingPrefix