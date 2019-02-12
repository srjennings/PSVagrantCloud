Function Invoke-VagrantCloudLocalToken {
<#
.SYNOPSIS
Grabs an API token from the local machine used for Vagrant Cloud.

.DESCRIPTION
This function will check the environment variables for the location of the Vagrant Cloud Token.
Vagrant Cloud looks for the variable "VARGRANT_CLOUD_TOKEN". This token should be present.
If the token is not present, this function will attempt to create a token.

.NOTES
This function only works on Windows at this time.

.EXAMPLE
Query the token and return a hash table, with the name and token values.
Invoke-VagrantCloudLocalToken

.EXAMPLE
Query the token and copy the token value to clipboard.
(Invoke-VagrantCloudLocalToken).token | clip

.INPUTS
none

.OUTPUTS
System.Management.Automation.PSCustomObject

.NOTES
Author: Steven Jennings <steven@automatingops.com>

Github: https://github.com/deyjcode/PSVagrantCloud
#>
    [CmdletBinding()]
    param (

    )
    Begin {
        Function Request-Restart {
            $AskRestartQuestion = Read-Host -Prompt "Would you like to reboot? [Y/n]"
            switch ($AskRestartQuestion) {
                'Y' {
                    Restart-Computer -Confirm
                }
                'N' {
                    return
                }
            }
        }
    }

    Process {
        $TokenName = "VAGRANT_CLOUD_TOKEN"

        try {
            $GrabToken = Get-Item "Env:\$TokenName" -ErrorAction Stop
            Write-Verbose "API Token already exists."
            $TokenObject = [PSCustomObject]@{
                Name  = $GrabToken.Name
                Token = $GrabToken.Value
            }
        }
        catch {
            Write-Warning "The environment variable $TokenName must be present!"
            $AskTokenQuestion = Read-Host -Prompt "Would you like to create the token now? [Y/n]"
            switch ($AskTokenQuestion) {
                'Y' {
                    $TokenDescription = New-VagrantCloudAPIToken -VagrantTokenDescription (Read-Host -Prompt "Enter a description for the token")
                    Write-Verbose "Writing Token Values..."
                    try {
                        switch ($PSVersionTable.PSEdition) {
                            'Core' {
                                Write-Verbose "PowerShell Core Detected..."
                                # What OS are we?
                                switch ($IsWindows) {
                                    $true {
                                        Write-Verbose "Windows Detected..."
                                        # https://docs.microsoft.com/en-us/dotnet/api/system.environment.setenvironmentvariable?view=netframework-4.7.2
                                        [Environment]::SetEnvironmentVariable("$TokenName", "$($TokenDescription.token)", "User")
                                        Write-Verbose "The environment variable $TokenName has been created."
                                        Write-Warning "It is recommended to reboot the system to ensure system variables are set!"
                                        Request-Restart
                                    }
                                    $false {
                                        if ($IsLinux) {
                                            Write-Verbose "Linux Detected..."
                                            if ((id -u) -eq '0') {
                                                Write-Warning "Running as sudo or root!"
                                                Write-Warning "It is recommended to run as a normal user, and preserve the variables using: 'sudo -E pwsh' as a matter of security"
                                                try {
                                                    Add-Content -Path ~/.bash_profile -Value "export $TokenName='"$($TokenDescription.token)"'" -ErrorAction Stop
                                                    Write-Warning "Restart PowerShell to apply the token changes."
                                                }
                                                catch {
                                                    $ErrorMessage = $_.Exception.Message
                                                    Write-Error $ErrorMessage
                                                }
                                            }
                                            else {
                                                Write-Host "Writing to non-sudo ~/.bash_profile"
                                                Add-Content -Path ~/.bash_profile -Value "export $TokenName='"$($TokenDescription.token)"'"
                                            }
                                        }
                                        # TODO: Add MacOS
                                    }
                                }
                            }
                            'Desktop' {
                                Write-Verbose "Windows PowerShell Detected..."
                                # https://docs.microsoft.com/en-us/dotnet/api/system.environment.setenvironmentvariable?view=netframework-4.7.2
                                [Environment]::SetEnvironmentVariable("$TokenName", "$($TokenDescription.token)", "User")
                                Write-Verbose "The environment variable $TokenName has been created."
                                Write-Warning "It is recommended to reboot the system to ensure system variables are set!"
                                Request-Restart
                            }
                        }
                    }
                    catch {
                        Write-Error "An unknown error occurred while setting the environment variable."
                    }
                }
                'N' {
                    Write-Warning "Unable to continue without a token. Exiting to prompt..."
                    return
                }
                default {
                    Write-Warning "Unable to continue without a token. Exiting to prompt..."
                    return
                }
            }
        }
        return $TokenObject
    }
}
