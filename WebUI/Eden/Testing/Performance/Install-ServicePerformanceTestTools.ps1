[CmdletBinding()]
param(
    $Settings,
    [String] $LoggingPrefix
)

    Write-EdenInfo "Installing the k6 open source performance testing platform" $LoggingPrefix
    sudo apt-key adv --keyserver hkp://keyserver.ubuntu.com:80 --recv-keys 379CE192D401AB61
    echo "deb https://dl.bintray.com/loadimpact/deb stable main" | sudo tee -a /etc/apt/sources.list
    sudo apt-get update
    sudo apt-get install k6
    Write-EdenInfo "Finished installing the k6 open source performance testing platform" $LoggingPrefix
