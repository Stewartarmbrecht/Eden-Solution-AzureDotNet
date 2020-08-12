[CmdletBinding()]
param(
    $Settings,
    [String] $LoggingPrefix
)

Write-EdenInfo "Building the MyEdenSolution.Audio.sln Solution continuously." $LoggingPrefix
dotnet watch --project ./MyEdenSolution.Audio.sln build ./MyEdenSolution.Audio.sln