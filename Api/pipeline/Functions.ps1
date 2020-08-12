function Write-EdenInfo {
    [CmdletBinding()]
    param(
        [String]$Message,
        [String]$LoggingPrefix
        )  
    Write-Host "$(Get-Date -UFormat "%Y-%m-%d %H:%M:%S") $($LoggingPrefix): $Message"  -ForegroundColor DarkCyan 
}
function Write-EdenError {
    [CmdletBinding()]
    param(
        [String]$Message,
        [String]$LoggingPrefix
    ) 
    Write-Host "$(Get-Date -UFormat "%Y-%m-%d %H:%M:%S") $($LoggingPrefix): $Message" -ForegroundColor DarkRed 
}
function Invoke-BuildCommand {
    [CmdletBinding()]
    param(
        [Parameter(Mandatory=$TRUE)]
        [String]$Command, 
        [Parameter(Mandatory=$TRUE)]
        [String]$LoggingPrefix, 
        [Parameter(Mandatory=$TRUE)]
        [String]$LogEntry,
        [switch]$ReturnResults,
        [switch]$Direct
    )
    Write-EdenInfo $LogEntry $LoggingPrefix
    # Write-EdenInfo "    In Direcotory: $(Get-Location)" $loggingPrefix
    try {
        # Write-EdenInfo "Invoking command: $Command" $LoggingPrefix
        # $result | Write-Verbose
        # Write-Debug $result.ToString()
        if ($ReturnResults) {
            $result = (Invoke-Expression $Command) 2>&1
            $result | Write-Verbose
            if ($LASTEXITCODE -ne 0) { throw $result }
            return $result
        } else {
            if ($Direct) {
                Invoke-Expression $Command
                if ($LASTEXITCODE -ne 0) { throw $result }
            } else {
                Invoke-Expression $Command | Write-Verbose
                if ($LASTEXITCODE -ne 0) { throw $result }
            }
        }
    } catch {
        Write-EdenError "Failed to execute command: $Command" $LoggingPrefix
        # Write-Error $_
        Write-EdenError "Exiting due to error!" $LoggingPrefix
    }
}

function Connect-AzureServicePrincipal {
    [CmdletBinding()]
    param(
        [String]$loggingPrefix
    )

    try 
    {
        $userName = $Env:UserName
        $password = $Env:Password
        $tenantId = $Env:TenantId
        $userId = $Env:UserId
        #$subscriptionId = $Env:SubscriptionId
    
        Write-EdenInfo "Connecting to Azure using User Id: $userId" $loggingPrefix
    
        $pswd = ConvertTo-SecureString $password
        $pscredential = New-Object System.Management.Automation.PSCredential($userId, $pswd)
        $result = Connect-AzAccount -ServicePrincipal -Credential $pscredential -Tenant $tenantId #-Subscription $subscriptionId
        if ($VerbosePreference) {$result}
    }
    catch
    {
        Write-EdenError 
        throw $_
    }
}

function Test-Automated
{
    [CmdletBinding()]
    param(
        [Parameter(Mandatory=$TRUE)]
        [String]$AutomatedUrl,
        [Parameter(Mandatory=$TRUE)]
        [String]$LoggingPrefix,
        [Parameter()]
        [switch]$Continuous
    )
    $automatedTestJob = Start-Job -Name "rt-Audio-Automated" -ScriptBlock {
        $AutomatedUrl = $args[0]
        $Continuous = $args[1]
        $LoggingPrefix = $args[2]
        $VerbosePreference = $args[3]

        . ./Functions.ps1
    
        $Env:AutomatedUrl = $AutomatedUrl
        Write-EdenInfo "This application does not have any automated tests yet.  Please add some!" $loggingPrefix
        # Write-EdenInfo "Running automated tests against '$AutomatedUrl'." $LoggingPrefix

        # if ($Continuous)
        # {
        #     Write-EdenInfo "Running automated tests continuously." $LoggingPrefix
        #     dotnet watch --project ./../tests/MyEdenSolution.Audio.Tests.csproj test --filter TestCategory=Automated
        # }
        # else
        # {
        #     Invoke-BuildCommand "dotnet test ./../tests/MyEdenSolution.Audio.Tests.csproj --filter TestCategory=Automated" $LoggingPrefix "Running automated tests once."
        #     Write-EdenInfo "Finished running automated tests." $LoggingPrefix
        # }
    } -ArgumentList @($AutomatedUrl, $Continuous, $LoggingPrefix, $VerbosePreference)
    return $automatedTestJob
}


