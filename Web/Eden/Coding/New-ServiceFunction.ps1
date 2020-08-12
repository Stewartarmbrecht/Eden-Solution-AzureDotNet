[CmdletBinding()]
param(
    [String] $Name,
    [String] $ServiceName,
    [String] $SolutionName,
    [String] $LoggingPrefix
)

    Write-EdenError "Functions are not relevant in an Angular web application.  Did you mean to create a service?" $LoggingPrefix
    Write-EdenError "Try: e-cscsvc -n $Name -svn $ServiceName -sln $SolutionName" $LoggingPrefix
