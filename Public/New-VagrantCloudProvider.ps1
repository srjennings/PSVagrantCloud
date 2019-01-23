Function New-VagrantCloudProvider {
<#

.SYNOPSIS
Updates a Vagrant Box on the Vagrant Cloud with new information.
This requires a Vagrant Cloud API Token to use.

.DESCRIPTION
This is a PowerShell Core wrapper for the Vagrant API.
This will create a new Vagrant Box Provider on the Vagrant Cloud. 

.PARAMETER VagrantCloudUsername
Your Vagrant Cloud Username
Alias: username

.PARAMETER BoxName
Your Vagrant Box Name
Alias: name

.PARAMETER VagrantCloudBoxProvider
The name of the provider.
Alias: provider

.PARAMETER VagrantCloudBoxProviderURL
A valid URL to download this provider. If omitted, you must upload the Vagrant box image for this provider to Vagrant Cloud before the provider can be used.
Alias: url

.EXAMPLE
New-VagrantCloudProvider -VagrantCloudUsername "vagrantadmin" -BoxName "ubuntu-bionic" -VagrantCloudBoxProvider "virtualbox" -VagrantCloudBoxProviderURL https://example.com/virtualbox-1.2.3.box -VagrantCloudToken "a5db113927404aeb84a8aa2fc5ec4d71"

Below is an example specifying values at the console window.

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
        [string]$BoxName,
        [alias("provider")]
        [string]$VagrantCloudBoxProvider,
        [alias("url")]
        [string]$VagrantCloudBoxProviderURL
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

    $VagrantAPIURI = "https://app.vagrantup.com/api/v1/box/$VagrantCloudUsername/$BoxName/version/$BoxVersion/providers"
    $VagrantAPIMethod = "POST"

    $VagrantCloudHeaders = @{
        Authorization = "Bearer $VagrantCloudToken"
    }

    # Create Box Provider Data
    $VagrantBoxProviderData = [ordered]@{
        name = $VagrantCloudBoxProvider
        url  = $VagrantCloudBoxProviderURL
    }

    # Create Nested Version Data for JSON
    $VersionHashTable = @{
        provider = $VagrantBoxProviderData
    }

    $NewBoxProviderJson = $VersionHashTable | ConvertTo-Json

    try {
        Invoke-RestMethod -Uri $VagrantAPIURI -Headers $VagrantCloudHeaders -Body $NewBoxProviderJson -Method $VagrantAPIMethod -ContentType "application/json"
    }
    catch {
        $Exception = $_
        Write-Error $Exception
    }
}