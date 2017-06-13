Function New-PlasterManifestXML
{
    [CmdletBinding()]
    param(
        [Parameter(
            Mandatory = $true,
            Position = 0
        )]
        [scriptblock]
        $ScriptBlock
    )

    $manifestBody = $ScriptBlock.Invoke()
    $manifest = @"
<?xml version="1.0" encoding="UTF-8"?>
<plasterManifest xmlns="http://www.microsoft.com/schemas/PowerShell/Plaster/v1" schemaVersion="1.0">
$($manifestBody)
</plasterManifest>
"@
    Write-Output -InputObject $manifest
}

New-Alias -Name PlasterManifest -Value New-PlasterManifestXML