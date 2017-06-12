Function Get-Parameters
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

    $subParams = $ScriptBlock.Invoke()
    $paramaterBlock = @"
<parameters>
$subParams
</parameters>

"@
    Write-Output -InputObject $paramaterBlock
}