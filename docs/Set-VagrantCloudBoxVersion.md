---
external help file: PSVagrantCloud-help.xml
Module Name: PSVagrantCloud
online version:
schema: 2.0.0
---

# Set-VagrantCloudBoxVersion

## SYNOPSIS
Updates a Vagrant Box on the Vagrant Cloud with new information.
This requires a Vagrant Cloud API Token to use.

## SYNTAX

```
Set-VagrantCloudBoxVersion [-VagrantCloudUsername] <String> [-BoxName] <String>
 [-VagrantCloudBoxVersion] <String> [-BoxVersionDescription] <String> [<CommonParameters>]
```

## DESCRIPTION
This is a PowerShell Core wrapper for the Vagrant API.
This will update Vagrant Box details on the Vagrant Cloud. 
This does not update box versions.
Use Set-VagrantCloudBoxVersion instead.

## EXAMPLES

### EXAMPLE 1
```
Set-VagrantCloudBoxVersion -VagrantCloudUsername "vagrantadmin" -BoxName "ubuntu-bionic" -BoxVersion "1.0.0" -BoxVersionDescription "Update Version" -VagrantCloudToken "a5db113927404aeb84a8aa2fc5ec4d71"
```

Changes details of an existing Vagrant Cloud Box Version.

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

### -VagrantCloudBoxVersion
{{Fill VagrantCloudBoxVersion Description}}

```yaml
Type: String
Parameter Sets: (All)
Aliases: version

Required: True
Position: 3
Default value: None
Accept pipeline input: False
Accept wildcard characters: False
```

### -BoxVersionDescription
{{Fill BoxVersionDescription Description}}

```yaml
Type: String
Parameter Sets: (All)
Aliases: description

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

## OUTPUTS

### System.Management.Automation.PSCustomObject
## NOTES
Author: Steven Jennings \<steven@automatingops.com\>

Github: https://github.com/deyjcode/PSVagrantCloud

## RELATED LINKS
