Function New-PlasterContentFile
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
        $Endcoding
    )

    New-PlasterContentBaseFile -FileType 'file' @PSBoundParameters
}

New-Alias -Name File -Value New-PlasterContentFile