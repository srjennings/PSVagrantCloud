---
external help file: PSVagrantCloud-help.xml
Module Name: PSVagrantCloud
online version:
schema: 2.0.0
---

# New-VagrantCloudAPIToken

## SYNOPSIS
Creates a new Vagrant Cloud API Token.

## SYNTAX

```
New-VagrantCloudAPIToken [[-VagrantTokenDescription] <String>] [[-Enable2FA] <Boolean>] [<CommonParameters>]
```

## DESCRIPTION
This is a PowerShell Core wrapper for the Vagrant API.
This function creates a new Vagrant Cloud API Token.

## EXAMPLES

### EXAMPLE 1
```
New-VagrantCloudAPIToken -VagrantCloudUsername "vagrantadmin" -VagrantCloudPassword "qcyq8aNhTbSj7q4" -VagrantTokenDescription "Generated with PowerShell!"
```

Below is an example specifying values at the console window.

## PARAMETERS

### -VagrantTokenDescription
The provider used by the Vagrant box
Alias: description

```yaml
Type: String
Parameter Sets: (All)
Aliases: description

Required: False
Position: 1
Default value: None
Accept pipeline input: False
Accept wildcard characters: False
```

### -Enable2FA
A two-factor authentication code.
Required to use this API method if 2FA is enabled.
Use New-Enable2FA to request a code.
Alias: 2facode

```yaml
Type: Boolean
Parameter Sets: (All)
Aliases: 2facode

Required: False
Position: 2
Default value: False
Accept pipeline input: False
Accept wildcard characters: False
```

### CommonParameters
This cmdlet supports the common parameters: -Debug, -ErrorAction, -ErrorVariable, -InformationAction, -InformationVariable, -OutVariable, -OutBuffer, -PipelineVariable, -Verbose, -WarningAction, and -WarningVariable.
For more information, see about_CommonParameters (http://go.microsoft.com/fwlink/?LinkID=113216).

## INPUTS

### System.Collections.Hashtable
## OUTPUTS

### System.Management.Automation.PSCustomObject
## NOTES
Author: Steven Jennings \<steven@automatingops.com\>

Github: https://github.com/deyjcode/PSVagrantCloud

## RELATED LINKS
