[CmdletBinding()]
param(
    $Settings,
    [String] $LoggingPrefix
)
    Write-EdenInfo "Testing the MyEdenSolution.Audio.sln Solution continuously using the 'Service.Tests/MyEdenSolution.Audio.Service.Tests'." $LoggingPrefix

    $testingActions = {
        $VerbosePreference = "Continue"
        Write-Host ""
        Write-EdenInfo "Testing the MyEdenSolution.Audio.sln Solution using the 'Service.Tests/MyEdenSolution.Audio.Service.Tests'." $LoggingPrefix
        dotnet test ./Service.Tests/MyEdenSolution.Audio.Service.Tests.csproj `
            --logger "trx;logFileName=testResults.trx" `
            --filter TestCategory!=Features `
            /p:CollectCoverage=true `
            /p:CoverletOutput=TestResults/ `
            /p:CoverletOutputFormat=lcov `
            /p:Include=`"[MyEdenSolution.Audio.Service*]*`" `
            /p:Threshold=80 `
            /p:ThresholdType=line `
            /p:ThresholdStat=total | Write-Host
        Write-EdenInfo "Finished testing the MyEdenSolution.Audio.sln Solution using the 'Service.Tests/MyEdenSolution.Audio.Service.Tests'." $LoggingPrefix
    
        Write-EdenInfo "Generating test results report to './Service.Tests/TestResults/allure'" $LoggingPrefix
        allure generate ./Service.Tests/TestResults/ -o ./Service.Tests/TestResults/Allure --clean | Write-Host
        Write-EdenInfo "Finished generating test results report to './Service.Tests/TestResults/allure'" $LoggingPrefix
    
        Write-EdenInfo "Generating code coverage reports to './Service.Tests/TestResults/coveragereport'" $LoggingPrefix
        reportgenerator "-reports:./Service.Tests/TestResults/Coverage.info" "-targetdir:Service.Tests/TestResults/coveragereport" -reporttypes:Html | Write-Host
        Write-EdenInfo "Finished generating code coverage reports to './Service.Tests/TestResults/coveragereport'" $LoggingPrefix    

        # Write-EdenInfo "Sleeping err working..." $LoggingPrefix    
        # Start-Sleep 2
        Write-EdenInfo "" $LoggingPrefix    
        Write-EdenInfo "Back to watching for changes..." $LoggingPrefix    
        Write-EdenInfo "" $LoggingPrefix    
    }

    Watch-EdenFolder `
        -Folder "." `
        -Filter "*.cs" `
        -Action $testingActions `
        -LoggingPrefix $LoggingPrefix `
        -Verbose