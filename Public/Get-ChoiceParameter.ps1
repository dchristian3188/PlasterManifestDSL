Function Get-ChoiceParameter
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
        $Default,

        [Parameter(
            ValueFromPipeline = $true
        )]
        [ValidateSet('Text','Encrypted')]
        [string]
        $Store,

        [Parameter(
            ValueFromPipeline = $true,
            Mandatory = $true,
            Position = 0
        )]
        [scriptblock]
        $ScriptBlock
    )

    $paramSB = [System.Text.StringBuilder]::new("<parameter name='$($Name)' type = 'choice' ")
    if($Prompt)
    {
        $paramSB.Append(" prompt='$($Prompt)'") > $null
    }

    if($Default)
    {
        $paramSB.Append(" default='$($Default)'") > $null
    }

    if($Store)
    {
        $paramSB.Append(" store='$($Store)'") > $null
    }
    $paramSB.AppendLine(">") > $null

    $choices = $ScriptBlock.Invoke() | 
        Out-String
    
    $paramSB.Append($choices) > $null
    $paramSB.Append("</parameter>") > $null
    Write-Output $paramSB.ToString()
}