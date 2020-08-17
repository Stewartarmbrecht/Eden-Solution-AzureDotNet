[CmdletBinding()]
param(
    $Settings,
    [String] $LoggingPrefix
)

    Write-EdenInfo "You already have everything you need. ;)" $LoggingPrefix

    # https://github.com/Arachni/arachni/releases/download/v1.5.1/arachni-1.5.1-0.5.12-linux-x86_64.tar.gz

    if ($IsLinux) {
        Set-Location ./Eden/Testing/Security
        New-Item -Path ./apps/Linux -ItemType Directory -Force
        Set-Location ./apps/Linux
        wget https://github.com/Arachni/arachni/releases/download/v1.5.1/arachni-1.5.1-0.5.12-linux-x86_64.tar.gz
        tar xzvf arachni-1.5.1-0.5.12-linux-x86_64.tar.gz
        Rename-Item ./arachni-1.5.1-0.5.12 ./arachni
    }
