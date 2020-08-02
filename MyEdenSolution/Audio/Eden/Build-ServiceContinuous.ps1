[CmdletBinding()]
param(
    $EdenEnvConfig,
    [String] $LoggingPrefix
)

Write-EdenBuildInfo "Building the MyEdenSolution.Audio.sln Solution continuously." $LoggingPrefix
dotnet watch --project ./MyEdenSolution.Audio.sln build ./MyEdenSolution.Audio.sln