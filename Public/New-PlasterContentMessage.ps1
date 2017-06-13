Function New-PlasterContentMessage
{
    [CmdletBinding()]
    param(
        [Parameter(
            ValueFromPipeline = $true,
            Mandatory = $true,
            Position = 0
        )]
        [string]
        $Message,

        [Parameter(
            ValueFromPipeline = $true,
            Position = 1
        )]
        [scriptblock]
        $Condition,

        [Parameter(
            ValueFromPipeline = $true
        )]
        [switch]
        $NoNewLine
    )

    $messageSB = [System.Text.StringBuilder]::new("<message")
    if ($NoNewLine)
    {
        $messageSB.Append(" nonewline='true'") > $null
    }
    
    if($Condition)
    {
        $messageSB.Append((New-Condition $Condition)) > $null
    }

    $messageSB.AppendLine(">$($Message)</message>") > $null
    Write-Output $messageSB.ToString()
}

New-Alias -Name Message -Value New-PlasterContentMessage  