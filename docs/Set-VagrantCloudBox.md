---
external help file: PSVagrantCloud-help.xml
Module Name: PSVagrantCloud
online version:
schema: 2.0.0
---

# Set-VagrantCloudBox

## SYNOPSIS
Updates a Vagrant Box on the Vagrant Cloud with new information.
This requires a Vagrant Cloud API Token to use.

## SYNTAX

```
Set-VagrantCloudBox [-VagrantCloudUsername] <String> [-BoxName] <String> [[-BoxIsPrivate] <Boolean>]
 [[-VagrantCloudBoxDescription] <String>] [<CommonParameters>]
```

## DESCRIPTION
This is a PowerShell Core wrapper for the Vagrant API.
This will update Vagrant Box details on the Vagrant Cloud. 
This does not update box versions.
Use Set-VagrantCloudBoxVersion instead.

## EXAMPLES

### EXAMPLE 1
```
Set-VagrantCloudBox -VagrantCloudUsername "vagrantadmin" -BoxName "ubuntu-bionic" -VagrantCloudBoxProvider "virtualbox" -VagrantCloudBoxDescription "Updated Ubuntu Description" -VagrantCloudToken "a5db113927404aeb84a8aa2fc5ec4d71" -BoxIsPrivate:$false
```

Sets details on the Vagrant Cloud Box and updates values.

### EXAMPLE 2
```
Get-VagrantCloudBox -VagrantCloudUsername vagrantadmin -BoxName win2012core -VagrantCloudToken "a5db113927404aeb84a8aa2fc5ec4d71" | Set-VagrantCloudBox.ps1 -VagrantCloudToken "a5db113927404aeb84a8aa2fc5ec4d71" -VagrantCloudBoxDescription "Pipelines!""
```

An example using PowerShell Pipeline mapping.

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

### -BoxIsPrivate
Optional.
Determines whether the box is a public or private box.
Accepts boolean values.
DEFAULT IS PRIVATE.
A Vagrant Cloud subscription is required to use private boxes.
Alias: is_private

```yaml
Type: Boolean
Parameter Sets: (All)
Aliases: is_private

Required: False
Position: 3
Default value: False
Accept pipeline input: False
Accept wildcard characters: False
```

### -VagrantCloudBoxDescription
A short description of the Vagrant Box, i.e, 'Windows Server 2019'
Alias: short_description

```yaml
Type: String
Parameter Sets: (All)
Aliases: short_description

Required: False
Position: 4
Default value: None
Accept pipeline input: False
Accept wildcard characters: False
```

### CommonParameters
This cmdlet supports the common parameters: -Debug, -ErrorAction, -ErrorVariable, -InformationAction, -InformationVariable, -OutVariable, -OutBuffer, -PipelineVariable, -Verbose, -WarningAction, and -WarningVariable.
For more information, see about_CommonParameters (http://go.microsoft.com/fwlink/?LinkID=113216).

## INPUTS

### System.Management.Automation.PSCustomObject
## OUTPUTS

### System.Management.Automation.PSCustomObject
## NOTES
Author: Steven Jennings \<steven@automatingops.com\>

Github: https://github.com/deyjcode/PSVagrantCloud

## RELATED LINKS
