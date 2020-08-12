[CmdletBinding()]
param(
    [String] $LoggingPrefix
)

    $isChromeInstalled = $false
    Write-EdenInfo "Checking if Chrome is installed." $LoggingPrefix
    try {
        google-chrome --version
        $isChromeInstalled = $true
        Write-EdenInfo "Chrome is installed." $LoggingPrefix
    }
    catch {
        $isChromeInstalled = $flase
    }
    if (!$isChromeInstalled) {
        Write-EdenInfo "Installing Google Chrome." $LoggingPrefix
        dpkg -s google-chrome-stable_current_amd64.deb
        wget https://dl.google.com/linux/direct/google-chrome-stable_current_amd64.deb
        sudo dpkg -i google-chrome-stable_current_amd64.deb
        sudo apt-get install -f
        if (Test-Path "google-chrome-stable_current_amd64.deb") {
            Remove-Item "google-chrome-stable_current_amd64.deb" -Force
        }
        Write-EdenInfo "Finished installing Google Chrome." $LoggingPrefix
    }

    $isLiveServerInstalled = $false
    Write-EdenInfo "Checking if Live Server is installed." $LoggingPrefix
    try {
        live-server --version
        $isLiveServerInstalled = $true
        Write-EdenInfo "Live Server is installed." $LoggingPrefix
    }
    catch {
        $isLiveServerInstalled = $false
    }
    if (!$isLiveServerInstalled) {
        Write-EdenInfo "Installing Live Server to run a web server for accessing html files." $LoggingPrefix
        npm install -g live-server
        Write-EdenInfo "Finished installing Live Server to run a web server for accessing html files." $LoggingPrefix
    }

