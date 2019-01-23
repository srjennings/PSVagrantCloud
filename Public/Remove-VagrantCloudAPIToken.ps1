Function Remove-VagrantCloudAPIToken {
<#

.SYNOPSIS
Removes a Vagrant Token from the Vagrant Cloud.
This requires a Vagrant Cloud API Token to use.

.DESCRIPTION
This is a PowerShell Core wrapper for the Vagrant API.
This will remove a specified Vagrant Token from the Vagrant Cloud. 

.EXAMPLE
Remove-VagrantCloudToken -VagrantCloudToken "a5db113927404aeb84a8aa2fc5ec4d71"

Removes a Vagrant Cloud API Token.

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

    $VagrantAPIURI = "https://app.vagrantup.com/api/v1/authenticate"
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
