Function New-VagrantCloudBoxVersion {
<#

.SYNOPSIS
Creates a version object for a Vagrant Box on the Vagrant Cloud.
This requires a Vagrant Cloud API Token to use.

.DESCRIPTION
This is a PowerShell Core wrapper for the Vagrant API.
This will create a Vagrant Box version on the Vagrant Cloud. 

.PARAMETER VagrantCloudUsername
Your Vagrant Cloud Username
Alias: username

.PARAMETER BoxName
Your Vagrant Box Name
Alias: name

.PARAMETER BoxVersionDescription
A short description of the Box version, i.e, 'Changes have been made to add packages'
Alias: description

.PARAMETER BoxVersion
A version incremental number. Uses Semantic Versioning. See related links for details.
Alias: version

.EXAMPLE
New-VagrantCloudBoxVersion -VagrantCloudUsername "vagrantadmin" -BoxName "ubuntu-bionic" -BoxVersion "1.0.0" -BoxVersionDescription "Initial Version" -VagrantCloudToken "a5db113927404aeb84a8aa2fc5ec4d71"

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
        [alias("version")]
        [string]$BoxVersion,
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

    $VagrantAPIURI = "https://app.vagrantup.com/api/v1/box/$VagrantCloudUsername/$BoxName/versions"
    $VagrantAPIMethod = "POST"

    $VagrantCloudHeaders = @{
        Authorization = "Bearer $VagrantCloudToken"
    }

    # Create Box Version Data
    $VagrantBoxVersionData = [ordered]@{
        version     = $BoxVersion
        description = $BoxVersionDescription
    }

    # Create Nested Version Data for JSON
    $VersionHashTable = @{
        version = $VagrantBoxVersionData
    }

    $NewBoxVersionJson = $VersionHashTable | ConvertTo-Json


    try {
        Invoke-RestMethod -Uri $VagrantAPIURI -Headers $VagrantCloudHeaders -Body $NewBoxVersionJson -Method $VagrantAPIMethod -ContentType "application/json"
    }
    catch {
        $Exception = $_
        Write-Error $Exception
    }
}
