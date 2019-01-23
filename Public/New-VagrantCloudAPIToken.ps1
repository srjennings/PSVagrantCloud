Function New-VagrantCloudAPIToken {
<#

.SYNOPSIS
Creates a new Vagrant Cloud API Token.

.DESCRIPTION
This is a PowerShell Core wrapper for the Vagrant API.
This function creates a new Vagrant Cloud API Token.

.PARAMETER Enable2FA
A two-factor authentication code. Required to use this API method if 2FA is enabled. Use New-Enable2FA to request a code.
Alias: 2facode

.PARAMETER VagrantTokenDescription
The provider used by the Vagrant box
Alias: description  

.EXAMPLE
New-VagrantCloudAPIToken -VagrantCloudUsername "vagrantadmin" -VagrantCloudPassword "qcyq8aNhTbSj7q4" -VagrantTokenDescription "Generated with PowerShell!"

Below is an example specifying values at the console window.

.INPUTS
System.Collections.Hashtable

.OUTPUTS
System.Management.Automation.PSCustomObject

.NOTES
Author: Steven Jennings <steven@automatingops.com>

Github: https://github.com/deyjcode/PSVagrantCloud
#>
    [CmdletBinding()]
    param(
        [alias("description")]
        [string]$VagrantTokenDescription,

        [alias("2facode")]
        [boolean]$Enable2FA
    )
    $VagrantAccountDetails = (Get-Credential -Message "Enter your Vagrant Cloud Account Information")
    $ConvertVagrantPassword = $VagrantAccountDetails.GetNetworkCredential().Password

    $VagrantAPIURI = "https://app.vagrantup.com/api/v1/authenticate"
    $VagrantAPIMethod = "POST"

    # Create token json dataset
    $TokenHash = [ordered]@{
        token = @{
            description = $VagrantTokenDescription
        }
        user  = [ordered]@{
            login    = $($VagrantAccountDetails.UserName)
            password = $ConvertVagrantPassword
        }
    }

    if ($Enable2FA) {
        # If account uses Two-Factor Authentication, we need to add such data to our original token dataset
        $2FACode = Read-Host -Prompt "Enter two-factor code"
        $2FAHashTable = @{
            two_factor = @{
                code = $2FACode
            }
        }
        $TokenHash += $2FAHashTable
    }

    $TokenData = $TokenHash | ConvertTo-Json -Compress

    try {
        Invoke-RestMethod -Uri $VagrantAPIURI -Body $TokenData -Method $VagrantAPIMethod -ContentType "application/json"
    }
    catch {
        $Exception = $_
        Write-Error $Exception
    }
}