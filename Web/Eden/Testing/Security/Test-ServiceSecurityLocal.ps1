[CmdletBinding()]
param(
    $Settings,
    [String] $LoggingPrefix
)

    Write-EdenInfo "Running the penetration tests." $LoggingPrefix
    New-Item -Path "./App/testresults/security" -ItemType Directory -Force
    ./Eden/Testing/Security/apps/Linux/arachni/bin/arachni `
        $Settings.PublicUrlToLocalWebServer `
        --report-save-path=./App/testresults/security/results.afr
    ./Eden/Testing/Security/apps/Linux/arachni/bin/arachni_reporter `
        ./App/testresults/security/results.afr `
        --reporter=html:outfile=./App/testresults/security/results.html.zip
    Expand-Archive -Path ./App/testresults/security/results.html.zip -DestinationPath ./App/testresults/security -Force
    Write-EdenInfo "Finished running the penetration tests." $LoggingPrefix
