---
external help file: PSVagrantCloud-help.xml
Module Name: PSVagrantCloud
online version:
schema: 2.0.0
---

# Set-VagrantCloudBoxProvider

## SYNOPSIS
Updates a Vagrant Provider on the Vagrant Cloud with new information.
This requires a Vagrant Cloud API Token to use.

## SYNTAX

```
Set-VagrantCloudBoxProvider [-VagrantCloudUsername] <String> [-ProviderName] <String> [-URL] <String>
 [<CommonParameters>]
```

## DESCRIPTION
This is a PowerShell Core wrapper for the Vagrant API.
This will update Vagrant Provider details on the Vagrant Cloud.

## EXAMPLES

### EXAMPLE 1
```
Set-VagrantCloudBoxProvider -VagrantCloudToken "a5db113927404aeb84a8aa2fc5ec4d71" -ProviderName "virtualbox-iso" -URL "https://example.com/virtualbox-1.2.3.box
```

Changes details of an existing Vagrant Cloud Box Provider.

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

### -ProviderName
Your Vagrant Provider Name

```yaml
Type: String
Parameter Sets: (All)
Aliases:

Required: True
Position: 2
Default value: None
Accept pipeline input: True (ByPropertyName)
Accept wildcard characters: False
```

### -URL
{{Fill URL Description}}

```yaml
Type: String
Parameter Sets: (All)
Aliases:

Required: True
Position: 3
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
