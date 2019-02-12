Function Set-VagrantCloudBoxVersion {
<#

.SYNOPSIS
Updates a Vagrant Box on the Vagrant Cloud with new information.
This requires a Vagrant Cloud API Token to use.

.DESCRIPTION
This is a PowerShell Core wrapper for the Vagrant API.
This will update Vagrant Box details on the Vagrant Cloud. 
This does not update box versions. Use Set-VagrantCloudBoxVersion instead.

.PARAMETER VagrantCloudUsername
Your Vagrant Cloud Username
Alias: username

.PARAMETER BoxName
Your Vagrant Box Name
Alias: name

.PARAMETER VagrantCloudBoxProvider
The provider used by the Vagrant box
Alias: provider

.PARAMETER VagrantCloudBoxDescription
A short description of the Vagrant Box, i.e, 'Windows Server 2019'
Alias: short_description

.PARAMETER BoxIsPrivate
Optional. Determines whether the box is a public or private box. Accepts boolean values.
DEFAULT IS PRIVATE. A Vagrant Cloud subscription is required to use private boxes.
Alias: is_private

.EXAMPLE
Set-VagrantCloudBoxVersion -VagrantCloudUsername "vagrantadmin" -BoxName "ubuntu-bionic" -BoxVersion "1.0.0" -BoxVersionDescription "Update Version" -VagrantCloudToken "a5db113927404aeb84a8aa2fc5ec4d71"

Changes details of an existing Vagrant Cloud Box Version.

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
        [parameter(
            Mandatory = $true
        )]
        [alias("version")]
        [string]$VagrantCloudBoxVersion,
        [parameter(
            Mandatory = $true
        )]
        [alias("description")]
        [string]$BoxVersionDescription
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
    
    $VagrantAPIURI = "https://app.vagrantup.com/api/v1/box/$VagrantCloudUsername/$BoxName/version/$VagrantCloudBoxVersion"
    $VagrantAPIMethod = "PUT"

    $VagrantCloudHeaders = @{
        Authorization = "Bearer $VagrantCloudToken"
    }

    # Update Box Version Data
    $VagrantBoxVersionData = [ordered]@{
        version     = $VagrantCloudBoxVersion
        description = $BoxVersionDescription
    }

    # Update Nested Version Data for JSON
    $VersionHashTable = @{
        version = $VagrantBoxVersionData
    }

    $UpdatedBoxVersionJson = $VersionHashTable | ConvertTo-Json

    try {
        Invoke-RestMethod -Uri $VagrantAPIURI -Headers $VagrantCloudHeaders -Body $UpdatedBoxVersionJson -Method $VagrantAPIMethod -ContentType "application/json"
    }
    catch {
        $Exception = $_
        Write-Error $Exception
    }
}
