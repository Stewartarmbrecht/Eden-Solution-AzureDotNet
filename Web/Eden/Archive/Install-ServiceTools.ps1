[CmdletBinding()]
param(
    $Settings,
    [String] $LoggingPrefix
)


    Write-EdenInfo "Installing Live Server to run a web server for accessing html files." $LoggingPrefix
    npm install -g live-server

    Write-EdenInfo "Installing Markserve to use for serving up markdown documentation." $LoggingPrefix
    npm i -g markserv

