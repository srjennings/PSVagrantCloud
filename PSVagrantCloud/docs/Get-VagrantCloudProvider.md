---
external help file: PSVagrantCloud-help.xml
Module Name: PSVagrantCloud
online version:
schema: 2.0.0
---

# Get-VagrantCloudProvider

## SYNOPSIS
Gathers information on a Vagrant Provider located in the Vagrant Cloud. 
This requires a Vagrant Cloud API Token to use.

## SYNTAX

```
Get-VagrantCloudProvider [-VagrantCloudUsername] <String> [-ProviderName] <String>
 [-VagrantCloudBoxName] <String> [-VagrantCloudBoxVersion] <String> [<CommonParameters>]
```

## DESCRIPTION
This is a PowerShell Core wrapper for the Vagrant API.
Gathers information on a Vagrant Provider located in the Vagrant Cloud.

## EXAMPLES

### EXAMPLE 1
```
Get-VagrantCloudBox -VagrantCloudUsername "vagrantadmin" -Provider "virtualbox" -VagrantCloudToken "a5db113927404aeb84a8aa2fc5ec4d71"
```

Returns information from Vagrant Cloud on the specified provider.

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
Alias: provider

```yaml
Type: String
Parameter Sets: (All)
Aliases: provider

Required: True
Position: 2
Default value: None
Accept pipeline input: False
Accept wildcard characters: False
```

### -VagrantCloudBoxName
The Box Name
Alias: name

```yaml
Type: String
Parameter Sets: (All)
Aliases: name

Required: True
Position: 3
Default value: None
Accept pipeline input: True (ByPropertyName)
Accept wildcard characters: False
```

### -VagrantCloudBoxVersion
{{Fill VagrantCloudBoxVersion Description}}

```yaml
Type: String
Parameter Sets: (All)
Aliases: version

Required: True
Position: 4
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
