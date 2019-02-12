---
external help file: PSVagrantCloud-help.xml
Module Name: PSVagrantCloud
online version:
schema: 2.0.0
---

# Remove-VagrantCloudBox

## SYNOPSIS
Removes a Vagrant Box from the Vagrant Cloud.
This requires a Vagrant Cloud API Token to use.

## SYNTAX

```
Remove-VagrantCloudBox [-VagrantCloudUsername] <String> [-BoxName] <String> [<CommonParameters>]
```

## DESCRIPTION
This is a PowerShell Core wrapper for the Vagrant API.
This will remove a specified Vagrant Box from the Vagrant Cloud.

## EXAMPLES

### EXAMPLE 1
```
Remove-VagrantCloudBox -VagrantCloudUsername "vagrantadmin" -BoxName "ubuntu-bionic" -VagrantCloudToken "a5db113927404aeb84a8aa2fc5ec4d71"
```

Removes a VagrantCloudBox.

## PARAMETERS

### -VagrantCloudUsername
Your Vagrant Cloud Username
Alias: username

```yaml
Type: String
Parameter Sets: (All)
Aliases: username

Required: True
Position: 1
Default value: None
Accept pipeline input: True (ByPropertyName)
Accept wildcard characters: False
```

### -BoxName
Your Vagrant Box Name
Alias: name

```yaml
Type: String
Parameter Sets: (All)
Aliases: name

Required: True
Position: 2
Default value: None
Accept pipeline input: True (ByPropertyName)
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
