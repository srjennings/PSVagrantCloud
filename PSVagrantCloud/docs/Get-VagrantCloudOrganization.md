---
external help file: PSVagrantCloud-help.xml
Module Name: PSVagrantCloud
online version:
schema: 2.0.0
---

# Get-VagrantCloudOrganization

## SYNOPSIS
Retrieves data on an organization.
This requires a Vagrant Cloud API Token to use.

## SYNTAX

```
Get-VagrantCloudOrganization [-VagrantCloudUser] <String> [<CommonParameters>]
```

## DESCRIPTION
This is a PowerShell Core wrapper for the Vagrant API.
Retrieves data on an organization.

## EXAMPLES

### EXAMPLE 1
```
Get-VagrantCloudOrganization -VagrantCloudToken "a5db113927404aeb84a8aa2fc5ec4d71"
```

Retrieves data on an organization.

## PARAMETERS

### -VagrantCloudUser
{{Fill VagrantCloudUser Description}}

```yaml
Type: String
Parameter Sets: (All)
Aliases: user

Required: True
Position: 1
Default value: None
Accept pipeline input: False
Accept wildcard characters: False
```

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
