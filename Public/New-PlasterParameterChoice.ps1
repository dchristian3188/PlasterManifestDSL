Function New-PlasterParameterChoice
{
    [CmdletBinding()]
    param(
        [Parameter(
            ValueFromPipeline = $true,
            Mandatory = $true,
            Position = 0
        )]
        [string]
        $Label,

        [Parameter(
            ValueFromPipeline = $true,
            Position = 1
        )]
        [string]
        $Value,

        [Parameter(
            ValueFromPipeline = $true,
            Position = 2
        )]
        [string]
        $Help
    )

    if(-not($Value))
    {
        $Value = $Label
    }

    $paramSB = [System.Text.StringBuilder]::new()
    $paramSB.AppendLine("   <choice label='&amp;$($Label)'") > $null
    $paramSB.AppendLine("       value='$($Value)'") > $null
    if ($Help)
    {
        $paramSB.AppendLine("       help='$($Help)'") > $null
    }

    $paramSB.Append('/>') > $null
    Write-Output $paramSB.ToString()
}

New-Alias -Name Choice -Value New-PlasterParameterChoice  