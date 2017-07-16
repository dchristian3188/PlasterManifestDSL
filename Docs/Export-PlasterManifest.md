---
external help file: PlasterManifestDSL-help.xml
online version:
schema: 2.0.0
---

# Export-PlasterManifest

## SYNOPSIS
Saves an XML manifest.

## SYNTAX

```
Export-PlasterManifest [-Manifest] <String> [-Destination] <String> [[-Endcoding] <String>] [-PassThru]
```

## DESCRIPTION
Used to save the xml manifest created by New-PlasterManifestXML.

## EXAMPLES

### Example 1
```
PlasterManifest {
    Metadata {
        Title = "My Posh Template"
        TemplateName = 'PoshTemp'
    }
    Content {
        File -Source 'myTemplate.txt' -Destination 'newProject.txt'
    }
} | Export-PlasterManifest -Destination PlasterManifest.xml
```

Exports a simple Plaster Manifest to a file called 'PlasterManifest.xml' in the current directory.

## PARAMETERS

### -Destination
Path to save the Plaster Manifest.

```yaml
Type: String
Parameter Sets: (All)
Aliases:

Required: True
Position: 1
Default value: None
Accept pipeline input: True (ByPropertyName)
Accept wildcard characters: False
```

### -Endcoding
File encoding to use when saving the manifest.

```yaml
Type: String
Parameter Sets: (All)
Aliases:

Required: False
Position: 2
Default value: None
Accept pipeline input: True (ByPropertyName)
Accept wildcard characters: False
```

### -Manifest
Plaster Manifest that will be saved.

```yaml
Type: String
Parameter Sets: (All)
Aliases:

Required: True
Position: 0
Default value: None
Accept pipeline input: True (ByPropertyName, ByValue)
Accept wildcard characters: False
```

### -PassThru
If preset will return an IO.FileInfo object for the saved file.

```yaml
Type: SwitchParameter
Parameter Sets: (All)
Aliases:

Required: False
Position: Named
Default value: None
Accept pipeline input: True (ByPropertyName)
Accept wildcard characters: False
```

## INPUTS

### System.String
System.Management.Automation.SwitchParameter


## OUTPUTS

### System.Object

## NOTES

## RELATED LINKS

