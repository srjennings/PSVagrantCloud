---
external help file: PSVagrantCloud-help.xml
Module Name: PSVagrantCloud
online version:
schema: 2.0.0
---

# Get-VagrantCloud2FACode

## SYNOPSIS
Sends a 2FA code to the requested delivery method. 
**Supports only sms at this time**

## SYNTAX

```
Get-VagrantCloud2FACode [<CommonParameters>]
```

## DESCRIPTION
This is a PowerShell Core wrapper for the Vagrant API.
Sends a 2FA code to the requested deliver method. 

This command is used in conjunction with New-VagrantCloudAPIToken when using the Enable2FA switch.

IMPORTANT: This will error out if two-factor authentication hasn't been enabled on the Vagrant Cloud dashboard!

## EXAMPLES

### EXAMPLE 1
```
Get-VagrantCloud2FACode
```

This will send a 2FA code via sms

## PARAMETERS

### CommonParameters
This cmdlet supports the common parameters: -Debug, -ErrorAction, -ErrorVariable, -InformationAction, -InformationVariable, -OutVariable, -OutBuffer, -PipelineVariable, -Verbose, -WarningAction, and -WarningVariable.
For more information, see about_CommonParameters (http://go.microsoft.com/fwlink/?LinkID=113216).

## INPUTS

### none
## OUTPUTS

### System.Management.Automation.PSCustomObject
## NOTES
Author: Steven Jennings \<steven@automatingops.com\>

Github: https://github.com/deyjcode/PSVagrantCloud

## RELATED LINKS
