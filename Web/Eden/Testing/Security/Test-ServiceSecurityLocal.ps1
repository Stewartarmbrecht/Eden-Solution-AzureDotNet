[CmdletBinding()]
param(
    $Settings,
    [String] $LoggingPrefix
)

    Write-EdenInfo "Running the penetration tests." $LoggingPrefix
    New-Item -Path "./Service/testresults/security" -ItemType Directory -Force
    ./Eden/Testing/Security/apps/Linux/arachni/bin/arachni `
        $Settings.PublicUrlToLocalWebServer `
        --report-save-path=./Service/testresults/security/results.afr
    ./Eden/Testing/Security/apps/Linux/arachni/bin/arachni_reporter `
        ./Service/testresults/security/results.afr `
        --reporter=html:outfile=./Service/testresults/security/results.html.zip
    Expand-Archive -Path ./Service/testresults/security/results.html.zip -DestinationPath ./Service/testresults/security -Force
    Write-EdenInfo "Finished running the penetration tests." $LoggingPrefix
