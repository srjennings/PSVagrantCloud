---
external help file: PSVagrantCloud-help.xml
Module Name: PSVagrantCloud
online version:
schema: 2.0.0
---

# Remove-VagrantCloudAPIToken

## SYNOPSIS
Removes a Vagrant Token from the Vagrant Cloud.
This requires a Vagrant Cloud API Token to use.

## SYNTAX

```
Remove-VagrantCloudAPIToken [<CommonParameters>]
```

## DESCRIPTION
This is a PowerShell Core wrapper for the Vagrant API.
This will remove a specified Vagrant Token from the Vagrant Cloud.

## EXAMPLES

### EXAMPLE 1
```
Remove-VagrantCloudToken -VagrantCloudToken "a5db113927404aeb84a8aa2fc5ec4d71"
```

Removes a Vagrant Cloud API Token.

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
