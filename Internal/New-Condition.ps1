Function New-Condition
{
    [CmdletBinding()]
    param(
        [Parameter(
            ValueFromPipeline = $true,
            Position = 1
        )]
        [scriptblock]
        $Condition
    )

    $conditionString = $Condition.Ast.EndBlock.Extent.Text
    Write-Output -InputObject (" condition='{$($conditionString)}'")
}

