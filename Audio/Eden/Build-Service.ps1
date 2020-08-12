[CmdletBinding()]
param(
    $Settings,
    [String] $LoggingPrefix
)

    Write-EdenInfo "Building the MyEdenSolution.Audio.sln Solution." $LoggingPrefix
    dotnet build ./MyEdenSolution.Audio.sln
    Write-EdenInfo "Finished building the MyEdenSolution.Audio.sln Solution." $LoggingPrefix
