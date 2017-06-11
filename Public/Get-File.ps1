Function Get-File
{
    [CmdletBinding()]
    param(
        [Parameter(
            ValueFromPipeline = $true,
            Mandatory = $true,
            Position = 0
        )]
        [string]
        $Source,

        [Parameter(
            ValueFromPipeline = $true,
            Mandatory = $true,
            Position = 1
        )]
        [string]
        $Destination,

        [Parameter(
            ValueFromPipeline = $true,
            Position = 2
        )]
        [scriptblock]
        $Condition,

        [Parameter(
            ValueFromPipeline = $true
        )]
        [switch]
        $OpenInEditor
    )

    $fileSB = [System.Text.StringBuilder]::new()
    $fileSB.AppendLine("<file source='$($Source)'") > $null
    $fileSB.AppendLine("    destination='$($Destination)'") > $null
    
    if($Condition)
    {
        $conditionString = Get-Condition -Condition $Condition
        $fileSB.AppendLine("   $conditionString") > $null
    }

    if($OpenInEditor)
    {
        $fileSB.Append("    OpenInEditor='true'") > $null
    }

    $fileSB.AppendLine('/>') > $null
    Write-Output -InputObject $fileSB.ToString()

}