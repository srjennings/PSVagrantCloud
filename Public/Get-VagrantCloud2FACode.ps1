Function Get-VagrantCloud2FACode {
<#

.SYNOPSIS
Sends a 2FA code to the requested delivery method. 
**Supports only sms at this time**

.DESCRIPTION
This is a PowerShell Core wrapper for the Vagrant API.
Sends a 2FA code to the requested deliver method. 

This command is used in conjunction with New-VagrantCloudAPIToken when using the Enable2FA switch.

IMPORTANT: This will error out if two-factor authentication hasn't been enabled on the Vagrant Cloud dashboard!

.EXAMPLE
Get-VagrantCloud2FACode

This will send a 2FA code via sms

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

    $VagrantAccountDetails = (Get-Credential -Message "Enter your Vagrant Cloud Account Information")
    $ConvertVagrantPassword = $VagrantAccountDetails.GetNetworkCredential().Password

    $VagrantAPIURI = "https://app.vagrantup.com/api/v1/two-factor/request-code"
    $VagrantAPIMethod = "POST"

    # Create token json dataset
    $TokenHash = [ordered]@{
        two_factor = @{
            delivery_method = "sms"
        }
        user       = [ordered]@{
            login    = $($VagrantAccountDetails.UserName)
            password = $ConvertVagrantPassword
        }
    }

    $TokenData = $TokenHash | ConvertTo-Json -Compress

    try {
        $SMSData = Invoke-RestMethod -Uri $VagrantAPIURI -Body $TokenData -Method $VagrantAPIMethod -ContentType "application/json"
        $ExtractedSMSNumber = ($SMSData.two_factor).obfuscated_destination

        Write-Output "A validation code has been sent to the $ExtractedSMSNumber"
    }
    catch {
        $Exception = $_
        Write-Error $Exception
    }
}