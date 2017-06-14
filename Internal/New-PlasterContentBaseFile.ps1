Function New-PlasterContentBaseFile
{
    [CmdletBinding()]
    param(
        [Parameter(
            ValueFromPipeline = $true,
            Mandatory = $true,
            Position = 0
        )]
        [AllowEmptyString()]
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
        $Endcoding,

        [Parameter(
            ValueFromPipeline = $true
        )]
        [ValidateSet('file', 'templateFile')]
        [string]
        $FileType
    )

    $fileSB = [System.Text.StringBuilder]::new("<$FileType")
    $fileSB.AppendLine(" source='$($Source)'") > $null
    $fileSB.AppendLine("    destination='$($Destination)'") > $null

    if ($Condition)
    {
        $conditionString = New-Condition -Condition $Condition
        $fileSB.AppendLine("   $conditionString") > $null
    }

    if ($OpenInEditor)
    {
        $fileSB.AppendLine("    OpenInEditor='true'") > $null
    }

    if($Endcoding)
    {
        $fileSB.AppendLine("    endcoding='$($Endcoding)'") > $null
    }

    $fileSB.Append('/>') > $null
    Write-Output -InputObject $fileSB.ToString().Trim(" ")
}
