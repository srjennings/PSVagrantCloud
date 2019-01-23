---
external help file: PSVagrantCloud-help.xml
Module Name: PSVagrantCloud
online version:
schema: 2.0.0
---

# Find-VagrantCloudBox

## SYNOPSIS
Search for Vagrant Cloud Boxes 
This requires a Vagrant Cloud API Token to use.

## SYNTAX

```
Find-VagrantCloudBox [[-q] <String>] [[-provider] <String>] [[-sort] <String>] [[-order] <String>]
 [[-limit] <Int32>] [[-page] <Int32>] [<CommonParameters>]
```

## DESCRIPTION
This is a PowerShell Core wrapper for the Vagrant API.
This will search and find Vagrant Cloud boxes utilizing a variety of arguments

## EXAMPLES

### EXAMPLE 1
```
Find-VagrantCloudBox
```

Run a wildcard query.

### EXAMPLE 2
```
Find-VagrantCloudBox -q hashicorp | select -ExpandProperty name
```

Query a specific username, and list the boxes.
In this example, username is 'hashicorp'.
Since the object returns the 'name' object in collapsed form, we need to expand the property to list it.

### EXAMPLE 3
```
Find-VagrantCloudBox -q hashicorp -provider vmware
```

Query the 'hashicorp' username for all boxes that use the 'vmware' provider.

### EXAMPLE 4
```
Find-VagrantCloudBox -q hashicorp -provider aws | select name,createddate,updateddate
```

Query the 'hashicorp' username for all boxes that use the 'aws' provider and list the name, createddate and updateddate fields.

## PARAMETERS

### -q
The search query.
Results will match the username, name, or short_description fields for a box.
If omitted, the top boxes based on sort and order will be returned (defaults to "downloads desc").

```yaml
Type: String
Parameter Sets: (All)
Aliases:

Required: False
Position: 1
Default value: None
Accept pipeline input: False
Accept wildcard characters: False
```

### -provider
Filter results to boxes supporting for a specific provider.

```yaml
Type: String
Parameter Sets: (All)
Aliases:

Required: False
Position: 2
Default value: None
Accept pipeline input: False
Accept wildcard characters: False
```

### -sort
The field to sort results on.
Can be one of "downloads", "created", or "updated".
Defaults to "downloads".

```yaml
Type: String
Parameter Sets: (All)
Aliases:

Required: False
Position: 3
Default value: Downloads
Accept pipeline input: False
Accept wildcard characters: False
```

### -order
The order to return the sorted field in.
Can be "desc" os "asc".
Defaults to "desc".

```yaml
Type: String
Parameter Sets: (All)
Aliases:

Required: False
Position: 4
Default value: Desc
Accept pipeline input: False
Accept wildcard characters: False
```

### -limit
The number of results to return (max of 100).
Defaults to "100".

```yaml
Type: Int32
Parameter Sets: (All)
Aliases:

Required: False
Position: 5
Default value: 100
Accept pipeline input: False
Accept wildcard characters: False
```

### -page
Specify pages.
Defaults to "1".

```yaml
Type: Int32
Parameter Sets: (All)
Aliases:

Required: False
Position: 6
Default value: 1
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
