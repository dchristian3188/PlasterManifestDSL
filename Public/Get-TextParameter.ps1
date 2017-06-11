Function Get-TextParameter
{
    [CmdletBinding()]
    param(
        [Parameter(
            ValueFromPipeline = $true,
            Mandatory = $true,
            Position = 0
        )]
        [string]
        $Name,

        [Parameter(
            ValueFromPipeline = $true,
            Position = 1
        )]
        [string]
        $Prompt,

        [Parameter(
            ValueFromPipeline = $true,
            Position = 2
        )]
        [string]
        $Default
    )

    $paramSB = [System.Text.StringBuilder]::new("<parameter name='$($Name)' type = 'text' ")
    if($Prompt)
    {
        $paramSB.Append(" prompt='$($Prompt)'") > $null
    }

    if($Default)
    {
        $paramSB.Append(" default='$($Default)'") > $null
    }
    
    $paramSB.AppendLine(" />") > $null
    Write-Output $paramSB.ToString()
}