Function New-PlasterContentNewModuleManifest
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

    $newScript = "[ordered]@{$($ScriptBlock.ToString())}"
    $newScriptBlock = [scriptblock]::Create($newScript)
    $manifestHash = & $newScriptBlock
    New-PlasterContentNewModuleManifestXML @manifestHash
}

New-Alias -Name NewModuleManifest -Value New-PlasterContentNewModuleManifest