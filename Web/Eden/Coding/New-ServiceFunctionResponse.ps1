[CmdletBinding()]
param(
    [String] $Name,
    [String] $ServiceName,
    [String] $SolutionName,
    [String] $LoggingPrefix
)

Write-EdenBuildError "Functions are not relevant in an Angular web application.  Did you mean to create a service?" $LoggingPrefix
Write-EdenBuildError "Try: e-cscsvc -n $Name -svn $ServiceName -sln $SolutionName" $LoggingPrefix
