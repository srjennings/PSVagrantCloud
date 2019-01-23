---
external help file: PSVagrantCloud-help.xml
Module Name: PSVagrantCloud
online version:
schema: 2.0.0
---

# Get-VagrantCloudAPIToken

## SYNOPSIS
Validates a API token located in the Vagrant Cloud. 
This requires a Vagrant Cloud API Token to use.

## SYNTAX

```
Get-VagrantCloudAPIToken [<CommonParameters>]
```

## DESCRIPTION
This is a PowerShell Core wrapper for the Vagrant API.
This function validates token on the Vagrant Cloud.

## EXAMPLES

### EXAMPLE 1
```
Get-VagrantCloudAPIToken -VagrantCloudToken "a5db113927404aeb84a8aa2fc5ec4d71"
```

Returns information from Vagrant Cloud on the specified api token.

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
