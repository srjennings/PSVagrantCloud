---
external help file: PSVagrantCloud-help.xml
Module Name: PSVagrantCloud
online version:
schema: 2.0.0
---

# New-VagrantCloudProvider

## SYNOPSIS
Updates a Vagrant Box on the Vagrant Cloud with new information.
This requires a Vagrant Cloud API Token to use.

## SYNTAX

```
New-VagrantCloudProvider [-VagrantCloudUsername] <String> [-BoxName] <String>
 [[-VagrantCloudBoxProvider] <String>] [[-VagrantCloudBoxProviderURL] <String>] [<CommonParameters>]
```

## DESCRIPTION
This is a PowerShell Core wrapper for the Vagrant API.
This will create a new Vagrant Box Provider on the Vagrant Cloud.

## EXAMPLES

### EXAMPLE 1
```
New-VagrantCloudProvider -VagrantCloudUsername "vagrantadmin" -BoxName "ubuntu-bionic" -VagrantCloudBoxProvider "virtualbox" -VagrantCloudBoxProviderURL https://example.com/virtualbox-1.2.3.box -VagrantCloudToken "a5db113927404aeb84a8aa2fc5ec4d71"
```

Below is an example specifying values at the console window.

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

### -VagrantCloudBoxProvider
The name of the provider.
Alias: provider

```yaml
Type: String
Parameter Sets: (All)
Aliases: provider

Required: False
Position: 3
Default value: None
Accept pipeline input: False
Accept wildcard characters: False
```

### -VagrantCloudBoxProviderURL
A valid URL to download this provider.
If omitted, you must upload the Vagrant box image for this provider to Vagrant Cloud before the provider can be used.
Alias: url

```yaml
Type: String
Parameter Sets: (All)
Aliases: url

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

### none
## OUTPUTS

### System.Management.Automation.PSCustomObject
## NOTES
Author: Steven Jennings \<steven@automatingops.com\>

Github: https://github.com/deyjcode/PSVagrantCloud

## RELATED LINKS
