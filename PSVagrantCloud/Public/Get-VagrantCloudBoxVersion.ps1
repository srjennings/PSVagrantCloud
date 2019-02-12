Function Get-VagrantCloudBoxVersion {
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

.PARAMETER VagrantCloudBoxVersion
A version incremental number. Uses Semantic Versioning. See related links for details.
Alias: version

.EXAMPLE
Get-VagrantBoxVersion -VagrantCloudUsername "vagrantadmin" -BoxName "ubuntu-bionic" -BoxVersion "1.0.0" -VagrantCloudToken "a5db113927404aeb84a8aa2fc5ec4d71"

Gets the Vagrant Box Version object.

.EXAMPLE
Get-VagrantCloudBox -VagrantCloudUsername "vagrantadmin" -BoxName "win2016core" | Get-VagrantCloudBoxVersion -VagrantCloudBoxVersion "1.0.1547129422"

Gets the Vagrant Box, win2016core with the specified version 1.0.1547129422

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
            Mandatory=$true,
            ValueFromPipelineByPropertyName=$true
        )]
        [alias("username")]
        [string]$VagrantCloudUsername,

        [parameter(
            Mandatory=$true,
            ValueFromPipelineByPropertyName=$true
        )]
        [alias("name")]
        [string]$BoxName,
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
    
    $VagrantAPIURI = "https://app.vagrantup.com/api/v1/box/$VagrantCloudUsername/$BoxName/version/$VagrantCloudBoxVersion"
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
