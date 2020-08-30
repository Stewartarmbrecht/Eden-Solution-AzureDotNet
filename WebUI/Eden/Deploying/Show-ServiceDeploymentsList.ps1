[CmdletBinding()]
param(
    $Settings,
    [String] $LoggingPrefix
)

    Write-EdenInfo "Connecting to Azure to get deployments for the Azure functions app." $LoggingPrefix
    $pscredential = New-Object System.Management.Automation.PSCredential( `
        $Settings.ServicePrincipalId, `
        (ConvertTo-SecureString $Settings.ServicePrincipalPassword)
    )
    Connect-AzAccount -ServicePrincipal -Credential $pscredential -Tenant $Settings.TenantId | Write-Verbose

    Get-AzResourceGroupDeployment -ResourceGroupName "$($Settings.EnvironmentName)-webui" `
        | Select-Object `
            DeploymentName, `
            Timestamp, `
            ProvisioningState, `
            Mode 
    Write-EdenInfo "Finished connecting to Azure to get deployments for the Azure functions app." $LoggingPrefix
