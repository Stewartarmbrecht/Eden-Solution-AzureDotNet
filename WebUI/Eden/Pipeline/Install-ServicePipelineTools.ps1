[CmdletBinding()]
param(
    $Settings,
    [String] $LoggingPrefix
)

Write-EdenInfo "Installing the Azure PowerShell commands." $LoggingPrefix
if ($PSVersionTable.PSEdition -eq 'Desktop' -and (Get-Module -Name AzureRM -ListAvailable)) {
    Write-Warning -Message ('Az module not installed. Having both the AzureRM and ' +
      'Az modules installed at the same time is not supported.')
} else {
    Install-Module -Name Az -AllowClobber -Scope CurrentUser
}
Write-EdenInfo "Finished installing the Azure PowerShell commands." $LoggingPrefix
