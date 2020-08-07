[CmdletBinding()]
param(
    [String] $LoggingPrefix
)

    $isChromeInstalled = $false
    Write-EdenBuildInfo "Checking if Chrome is installed." $LoggingPrefix
    try {
        google-chrome --version
        $isChromeInstalled = $true
        Write-EdenBuildInfo "Chrome is installed." $LoggingPrefix
    }
    catch {
        $isChromeInstalled = $flase
    }
    if (!$isChromeInstalled) {
        Write-EdenBuildInfo "Installing Google Chrome." $LoggingPrefix
        dpkg -s google-chrome-stable_current_amd64.deb
        wget https://dl.google.com/linux/direct/google-chrome-stable_current_amd64.deb
        sudo dpkg -i google-chrome-stable_current_amd64.deb
        sudo apt-get install -f
        if (Test-Path "google-chrome-stable_current_amd64.deb") {
            Remove-Item "google-chrome-stable_current_amd64.deb" -Force
        }
        Write-EdenBuildInfo "Finished installing Google Chrome." $LoggingPrefix
    }

    $isLiveServerInstalled = $false
    Write-EdenBuildInfo "Checking if Live Server is installed." $LoggingPrefix
    try {
        live-server --version
        $isLiveServerInstalled = $true
        Write-EdenBuildInfo "Live Server is installed." $LoggingPrefix
    }
    catch {
        $isLiveServerInstalled = $false
    }
    if (!$isLiveServerInstalled) {
        Write-EdenBuildInfo "Installing Live Server to run a web server for accessing html files." $LoggingPrefix
        npm install -g live-server
        Write-EdenBuildInfo "Finished installing Live Server to run a web server for accessing html files." $LoggingPrefix
    }

