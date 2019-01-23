Function New-VagrantCloudBox {
<#

.SYNOPSIS
Creates a new Vagrant Box on the Vagrant Cloud. 
This requires a Vagrant Cloud API Token to use.

.DESCRIPTION
This is a PowerShell Core wrapper for the Vagrant API.
This function creates a new Vagrant Box on the Vagrant Cloud.

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
New-VagrantCloudBox -VagrantCloudUsername "vagrantadmin" -BoxName "ubuntu-bionic" -VagrantCloudBoxProvider "virtualbox" -VagrantCloudBoxDescription "Ubuntu Bionic" -VagrantCloudToken "a5db113927404aeb84a8aa2fc5ec4d71" -BoxIsPrivate:$false

Below is an example specifying values at the console window.

.EXAMPLE
New-VagrantCloudBox -username 'vagrantadmin' -name 'ubuntu-bionic' -token 'a5db113927404aeb84a8aa2fc5ec4d71' -provider 'virtualbox' -description 'Ubuntu Bionic' -is_private:$false

Creates a new box. One can also use a hashtable and splat the values as well.

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
        [alias("short_description")]
        [string]$VagrantCloudBoxDescription,
        [alias("is_private")]
        [switch]$BoxIsPrivate
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

    $VagrantAPIURI = "https://app.vagrantup.com/api/v1/boxes"
    $VagrantAPIMethod = "POST"

    $VagrantCloudHeaders = @{
        Authorization = "Bearer $VagrantCloudToken"
    }

    # Create Private Box Data Set
    $VagrantBoxData = [ordered]@{
        username          = $VagrantCloudUsername
        name              = $BoxName
        short_description = $VagrantCloudBoxDescription
    }
    if ($BoxIsPrivate.IsPresent) {
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