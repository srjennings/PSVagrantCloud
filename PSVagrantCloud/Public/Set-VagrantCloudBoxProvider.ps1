Function Set-VagrantCloudBoxProvider {
<#

.SYNOPSIS
Updates a Vagrant Provider on the Vagrant Cloud with new information.
This requires a Vagrant Cloud API Token to use.

.DESCRIPTION
This is a PowerShell Core wrapper for the Vagrant API.
This will update Vagrant Provider details on the Vagrant Cloud. 

.PARAMETER VagrantCloudUsername
Your Vagrant Cloud Username
Alias: username

.PARAMETER ProviderName
Your Vagrant Provider Name

.EXAMPLE
Set-VagrantCloudBoxProvider -VagrantCloudToken "a5db113927404aeb84a8aa2fc5ec4d71" -ProviderName "virtualbox-iso" -URL "https://example.com/virtualbox-1.2.3.box

Changes details of an existing Vagrant Cloud Box Provider.

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
        [string]$ProviderName,

        [parameter(
            Mandatory = $true
        )]
        [string]$URL
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
    
    $VagrantAPIURI = "https://app.vagrantup.com/api/v1/box/$VagrantCloudUsername/$BoxName/version/$BoxVersion/provider/$ProviderName"
    $VagrantAPIMethod = "PUT"

    $VagrantCloudHeaders = @{
        Authorization = "Bearer $VagrantCloudToken"
    }

    # Update Provider Data
    $VagrantProviderData = [ordered]@{
        name = $ProviderName
        url  = $URL
    }

    # Update Nested Version Data for JSON
    $ProviderHashTable = @{
        provider = $VagrantProviderData
    }

    $UpdatedProviderJson = $ProviderHashTable | ConvertTo-Json

    try {
        Invoke-RestMethod -Uri $VagrantAPIURI -Headers $VagrantCloudHeaders -Body $UpdatedProviderJson -Method $VagrantAPIMethod -ContentType "application/json"
    }
    catch {
        $Exception = $_
        Write-Error $Exception
    }
}
