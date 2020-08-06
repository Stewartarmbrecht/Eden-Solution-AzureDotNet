[CmdletBinding()]
param(
    $Settings,
    [String] $LoggingPrefix
)

    Write-EdenBuildInfo "Building the MyEdenSolution.Audio.sln Solution." $LoggingPrefix
    dotnet build ./MyEdenSolution.Audio.sln
    Write-EdenBuildInfo "Finished building the MyEdenSolution.Audio.sln Solution." $LoggingPrefix
