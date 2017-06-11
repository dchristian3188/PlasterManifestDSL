Function Get-Condition
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

    $conditionString = $Condition.ToString()
    $conditionString = $conditionString -replace '^\r\n',''
    $conditionString = $conditionString.Trim(" ")
    $conditionString = $conditionString -replace '\r\n$',''
    
    Write-Output -InputObject (" condition='{$($conditionString)}'")
}