[CmdletBinding()]
param(
    $Settings,
    [String] $LoggingPrefix
)

Write-Verbose "Location: $(Get-Location)"

$resourceGroupName = "$($Settings.EnvironmentName)-audio".ToLower()
$apiName = "$($Settings.EnvironmentName)-audio".ToLower()
$apiFilePath = "$PSSCriptRoot/../.dist/app.zip"

Write-EdenBuildInfo "Connecting to azure tenant using the following configuration:" $loggingPrefix

Write-EdenBuildInfo "SolutionName       : $($Settings.SolutionName)" $LoggingPrefix
Write-EdenBuildInfo "ServiceName        : $($Settings.ServiceName)" $LoggingPrefix
Write-EdenBuildInfo "EnvironmentName    : $($Settings.EnvironmentName)" $LoggingPrefix
Write-EdenBuildInfo "Region             : $($Settings.Region)" $LoggingPrefix
Write-EdenBuildInfo "ServicePrincipalId : $($Settings.ServicePrincipalId)" $LoggingPrefix
Write-EdenBuildInfo "TenantId           : $($Settings.TenantId)" $LoggingPrefix
Write-EdenBuildInfo "DeveloperId        : $($Settings.DeveloperId)" $LoggingPrefix

$pscredential = New-Object System.Management.Automation.PSCredential($Settings.ServicePrincipalId, (ConvertTo-SecureString $Settings.ServicePrincipalPassword))
Connect-AzAccount -ServicePrincipal -Credential $pscredential -Tenant $Settings.TenantId | Write-Verbose

Write-Verbose "Location: $(Get-Location)"

Write-EdenBuildInfo "Deploying the azure functions app using zip from '$apiFilePath' to group '$resourceGroupName', app '$apiName' on the staging slot." $LoggingPrefix
Write-Verbose "Location: $(Get-Location)"
Write-Verbose "Api File Path: $apiFilePath"
$result = Publish-AzWebApp -ResourceGroupName $resourceGroupName -Name $apiName -Slot Staging -ArchivePath $apiFilePath -Force
if ($VerbosePreference -ne 'SilentlyContinue') { $result }