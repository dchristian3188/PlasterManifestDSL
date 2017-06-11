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

    $ScriptBlock.Invoke()
}