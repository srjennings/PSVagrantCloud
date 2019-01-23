Function Get-VagrantCloudBox {
<#

.SYNOPSIS
Gathers information on a Vagrant Box located in the Vagrant Cloud. 
This requires a Vagrant Cloud API Token to use.

.DESCRIPTION
This is a PowerShell Core wrapper for the Vagrant API.
This function gathers information on a Vagrant Box in the Vagrant Cloud.

.PARAMETER VagrantCloudUsername
Your Vagrant Cloud Username
Alias: username

.PARAMETER BoxName
Your Vagrant Box Name
Alias: name

.EXAMPLE
Get-VagrantCloudBox -VagrantCloudUsername "vagrantadmin" -BoxName "ubuntu-bionic" -VagrantCloudToken "a5db113927404aeb84a8aa2fc5ec4d71"

Returns information from Vagrant Cloud on the specified box.

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
            Mandatory = $true
        )]
        [alias("username")]
        [string]$VagrantCloudUsername,

        [parameter(
            Mandatory = $true
        )]
        [alias("name")]
        [string]$BoxName
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

    $GrabToken = (Get-Item "Env:\VAGRANT_CLOUD_TOKEN")
    $VagrantCloudToken = $GrabToken.value

    $VagrantAPIURI = "https://app.vagrantup.com/api/v1/box/$VagrantCloudUsername/$BoxName"
    $VagrantAPIMethod = "GET"

    $VagrantCloudHeaders = @{
        Authorization = "Bearer $VagrantCloudToken"
    }

    try {
        Invoke-RestMethod -Uri $VagrantAPIURI -Headers $VagrantCloudHeaders -Body $AddBoxJson -Method $VagrantAPIMethod -ContentType "application/json"
    }
    catch {
        $Exception = $_
        Write-Error $Exception
    }
}
