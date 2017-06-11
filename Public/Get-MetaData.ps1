Function Get-Metadata
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
    $metaHash = & $newScriptBlock
    New-Metadata @metaHash
}