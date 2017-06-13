Function New-PlasterContentBlock
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

    $subContent = $ScriptBlock.Invoke()
    $contentBlock = @"
<content>
$subContent
</content>

"@
    Write-Output -InputObject $contentBlock
}

New-Alias -Name Content -Value New-PlasterContentBlock  