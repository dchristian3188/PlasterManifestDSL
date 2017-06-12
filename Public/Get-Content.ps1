Function Get-Content
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