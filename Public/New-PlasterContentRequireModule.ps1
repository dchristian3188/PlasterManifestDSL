Function New-PlasterContentRequireModule
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
            ValueFromPipelineByPropertyName = $true
        )]
        [string]
        $MinimumVersion,

        [Parameter(
            ValueFromPipelineByPropertyName = $true
        )]
        [string]
        $MaximumVersion,

        [Parameter(
            ValueFromPipelineByPropertyName = $true
        )]
        [string]
        $RequiredVersion,

        [Parameter(
            ValueFromPipelineByPropertyName = $true
        )]
        [string]
        $Message,

        [Parameter(
            ValueFromPipeline = $true,
            Position = 1
        )]
        [scriptblock]
        $Condition
    )

    $requiredModuleSB = [System.Text.StringBuilder]::new('<requireModule name="{0}"' -f $Name)

    if($MinimumVersion)
    {
        $requiredModuleSB.AppendLine('  minimumVersion="{0}"' -f $MinimumVersion) > $null
    }

    if($MaximumVersion)
    {
        $requiredModuleSB.AppendLine('  maximumVersion="{0}"' -f $MaximumVersion) > $null
    }

    if($RequiredVersion)
    {
        $requiredModuleSB.AppendLine('  requiredVersion="{0}"' -f $RequiredVersion) > $null
    }

    if($Message)
    {
        $requiredModuleSB.AppendLine('  message="{0}"' -f $Message) > $null
    }

    if($Condition)
    {
        $conditionString = New-Condition -Condition $Condition
        $requiredModuleSB.AppendLine("  $conditionString") > $null
    }

    $requiredModuleSB.AppendLine('/>') > $null
    Write-Output $requiredModuleSB.ToString()

}

New-Alias -Name RequireModule -Value New-PlasterContentRequireModule