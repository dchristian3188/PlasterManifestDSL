Function New-PlasterContentTemplateFile
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
        $OpenInEditor,

        [Parameter(
            ValueFromPipeline = $true
        )]
        [ValidateSet('Default','Ascii','BigEndianUnicode','BigEndianUTF32','Oem','Unicode','UTF32','UTF7','UTF8','UTF8-NoBOM')]
        [string]
        $Endcoding
    )

    $fileSB = [System.Text.StringBuilder]::new()
    $fileSB.AppendLine("<templateFile source='$($Source)'") > $null
    $fileSB.AppendLine("    destination='$($Destination)'") > $null
    
    if($Condition)
    {
        $conditionString = New-Condition -Condition $Condition
        $fileSB.AppendLine("   $conditionString") > $null
    }

    if($OpenInEditor)
    {
        $fileSB.Append("    OpenInEditor='true'") > $null
    }

    if($Endcoding)
    {
        $fileSB.Append("    endcoding='$($Endcoding)'") > $null
    }

    $fileSB.AppendLine('/>') > $null
    Write-Output -InputObject $fileSB.ToString()

}

New-Alias -Name TemplateFile -Value New-PlasterContentTemplateFile