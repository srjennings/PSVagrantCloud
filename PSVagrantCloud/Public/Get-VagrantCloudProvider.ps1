Function Get-VagrantCloudProvider {
<#

.SYNOPSIS
Gathers information on a Vagrant Provider located in the Vagrant Cloud. 
This requires a Vagrant Cloud API Token to use.

.DESCRIPTION
This is a PowerShell Core wrapper for the Vagrant API.
Gathers information on a Vagrant Provider located in the Vagrant Cloud. 

.PARAMETER VagrantCloudUsername
Your Vagrant Cloud Username
Alias: username

.PARAMETER VagrantCloudBoxName
The Box Name
Alias: name

.PARAMETER ProviderName
Your Vagrant Provider Name
Alias: provider

.PARAMETER Version
The Provider Version

.EXAMPLE
Get-VagrantCloudBox -VagrantCloudUsername "vagrantadmin" -Provider "virtualbox" -VagrantCloudToken "a5db113927404aeb84a8aa2fc5ec4d71"

Returns information from Vagrant Cloud on the specified provider.

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
            Mandatory = $true
        )]
        [alias("provider")]
        [string]$ProviderName,

        [parameter(
            Mandatory = $true,
            ValueFromPipelineByPropertyName=$true
        )]
        [alias("name")]
        [string]$VagrantCloudBoxName,

        [parameter(
            Mandatory = $true
        )]
        [alias("version")]
        [string]$VagrantCloudBoxVersion
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

    $VagrantAPIURI = "https://app.vagrantup.com/api/v1/box/$VagrantCloudUsername/$VagrantCloudBoxName/version/$VagrantCloudBoxVersion/provider/$ProviderName"
    $VagrantAPIMethod = "GET"

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