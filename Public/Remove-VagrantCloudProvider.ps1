Function Remove-VagrantCloudProvider {
<#

.SYNOPSIS
Removes a Vagrant Provider on the Vagrant Cloud.
This requires a Vagrant Cloud API Token to use.

.DESCRIPTION
This is a PowerShell Core wrapper for the Vagrant API.
Removes a Vagrant Provider on the Vagrant Cloud.

.PARAMETER VagrantCloudUsername
Your Vagrant Cloud Username
Alias: username

.PARAMETER ProviderName
Your Vagrant Provider Name
Alias: name

.PARAMETER ProviderVersion
A version incremental number. Uses Semantic Versioning. See related links for details.
Alias: version

.EXAMPLE
Remove-VagrantCloudProvider -VagrantCloudUsername "vagrantadmin" -ProviderName "virtualbox" -ProviderVersion "1.0.0" -VagrantCloudToken "a5db113927404aeb84a8aa2fc5ec4d71"

Removes a Vagrant Cloud Provider.

.INPUTS
none

.OUTPUTS
System.Management.Automation.PSCustomObject

.NOTES
Author: Steven Jennings <steven@automatingops.com>

Github: https://github.com/deyjcode/PSVagrantCloud
#>
    [CmdletBinding()]
    param(
        [parameter(
            Mandatory = $true,
            ValueFromPipelineByPropertyName=$true
        )]
        [alias("username")]
        [string]$VagrantCloudUsername,

        [parameter(
            Mandatory = $true,
            ValueFromPipelineByPropertyName=$true
        )]
        [alias("name")]
        [string]$ProviderName,
        [alias("version")]
        [string]$ProviderVersion
    )

    $TokenName = "VAGRANT_CLOUD_TOKEN"
    try {
        $GrabToken = Get-Item "Env:\$TokenName" -ErrorAction SilentlyContinue
        Write-Verbose "API Token already exists."
        $VagrantCloudToken = $GrabToken.value
    }
    catch {
        Write-Host "We need to create a Vagrant Cloud Token..."
        Invoke-VagrantCloudLocalToken
        $GrabToken = Get-Item "Env:\$TokenName" -ErrorAction SilentlyContinue
        $VagrantCloudToken = $GrabToken.value
    }
    
    $VagrantAPIURI = "https://app.vagrantup.com/api/v1/box/$VagrantCloudUsername/$ProviderName/version/$ProviderVersion"
    $VagrantAPIMethod = "DELETE"

    $VagrantCloudHeaders = @{
        Authorization = "Bearer $VagrantCloudToken"
    }

    try {
        Invoke-RestMethod -Uri $VagrantAPIURI -Headers $VagrantCloudHeaders -Method $VagrantAPIMethod -ContentType "application/json"
    }
    catch {
        $Exception = $_
        Write-Error $Exception
    }
}
