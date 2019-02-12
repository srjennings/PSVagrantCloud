---
external help file: PSVagrantCloud-help.xml
Module Name: PSVagrantCloud
online version:
schema: 2.0.0
---

# New-VagrantCloudBox

## SYNOPSIS
Creates a new Vagrant Box on the Vagrant Cloud. 
This requires a Vagrant Cloud API Token to use.

## SYNTAX

```
New-VagrantCloudBox [-VagrantCloudUsername] <String> [-BoxName] <String>
 [[-VagrantCloudBoxDescription] <String>] [-BoxIsPrivate] [<CommonParameters>]
```

## DESCRIPTION
This is a PowerShell Core wrapper for the Vagrant API.
This function creates a new Vagrant Box on the Vagrant Cloud.

## EXAMPLES

### EXAMPLE 1
```
New-VagrantCloudBox -VagrantCloudUsername "vagrantadmin" -BoxName "ubuntu-bionic" -VagrantCloudBoxProvider "virtualbox" -VagrantCloudBoxDescription "Ubuntu Bionic" -VagrantCloudToken "a5db113927404aeb84a8aa2fc5ec4d71" -BoxIsPrivate:$false
```

Below is an example specifying values at the console window.

### EXAMPLE 2
```
New-VagrantCloudBox -username 'vagrantadmin' -name 'ubuntu-bionic' -token 'a5db113927404aeb84a8aa2fc5ec4d71' -provider 'virtualbox' -description 'Ubuntu Bionic' -is_private:$false
```

Creates a new box.
One can also use a hashtable and splat the values as well.

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

### -VagrantCloudBoxDescription
A short description of the Vagrant Box, i.e, 'Windows Server 2019'
Alias: short_description

```yaml
Type: String
Parameter Sets: (All)
Aliases: short_description

Required: False
Position: 3
Default value: None
Accept pipeline input: False
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
Type: SwitchParameter
Parameter Sets: (All)
Aliases: is_private

Required: False
Position: Named
Default value: False
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
