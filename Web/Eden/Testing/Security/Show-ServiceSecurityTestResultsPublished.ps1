[CmdletBinding()]
param(
    $Settings,
    [String] $LoggingPrefix
)

Write-EdenInfo "Generating the Penetration html test results report from the published afr file." $LoggingPrefix
New-Item -Path "./Service/testresults/publishedsecurity" -ItemType Directory -Force
./Eden/Testing/Security/apps/Linux/arachni/bin/arachni_reporter `
    ./Reports/TestResults/Security.afr `
    --reporter=html:outfile=./Service/testresults/publishedsecurity/results.html.zip
Expand-Archive -Path ./Service/testresults/publishedsecurity/results.html.zip -DestinationPath ./Service/testresults/publishedsecurity -Force
Write-EdenInfo "Generating the Penetration html test results report from the published afr file." $LoggingPrefix

Write-EdenInfo "Launching a browser to load the published security report at './Service/testresults/publishedsecurity/index.html'." $LoggingPrefix

Write-Host "" -ForegroundColor Blue
Write-Host "Click: http://localhost:8094/index.html" -ForegroundColor Blue
Write-Host "" -ForegroundColor Blue
Set-Location "./Service/testresults/publishedsecurity/"
live-server --port=8094 --open=index.html

