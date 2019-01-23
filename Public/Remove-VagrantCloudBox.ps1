Function Remove-VagrantCloudBox {
<#

.SYNOPSIS
Removes a Vagrant Box from the Vagrant Cloud.
This requires a Vagrant Cloud API Token to use.

.DESCRIPTION
This is a PowerShell Core wrapper for the Vagrant API.
This will remove a specified Vagrant Box from the Vagrant Cloud. 

.PARAMETER VagrantCloudUsername
Your Vagrant Cloud Username
Alias: username

.PARAMETER BoxName
Your Vagrant Box Name
Alias: name

.EXAMPLE
Remove-VagrantCloudBox -VagrantCloudUsername "vagrantadmin" -BoxName "ubuntu-bionic" -VagrantCloudToken "a5db113927404aeb84a8aa2fc5ec4d71"

Removes a VagrantCloudBox.

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

    $VagrantAPIURI = "https://app.vagrantup.com/api/v1/box/$VagrantCloudUsername/$BoxName"
    $VagrantAPIMethod = "DELETE"

    $VagrantCloudHeaders = @{
        Authorization = "Bearer $VagrantCloudToken"
    }

    # Create Private Box Data Set
    $VagrantBoxData = [ordered]@{
        username = $VagrantCloudUsername
        name     = $BoxName
    }
    if ($BoxIsPrivate) {
        $VagrantBoxData.Add("is_private", $true)
    }
    else {
        $VagrantBoxData.Add("is_private", $false)
    }

    # Create Nested Box Data for JSON
    $CreateBoxHashTable = @{
        box = $VagrantBoxData
    }
    # Create JSON necessary for submission
    $AddBoxJson = $CreateBoxHashTable | ConvertTo-Json -Compress

    try {
        Invoke-RestMethod -Uri $VagrantAPIURI -Headers $VagrantCloudHeaders -Body $AddBoxJson -Method $VagrantAPIMethod -ContentType "application/json"
    }
    catch {
        $Exception = $_
        Write-Error $Exception
    }
}