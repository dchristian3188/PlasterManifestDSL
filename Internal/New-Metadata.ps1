Function New-Metadata
{
    [CmdletBinding()]
    param(
        [Parameter(
            ValueFromPipeline = $true,
            Mandatory = $true,
            Position = 0
        )]
        [string]
        $TemplateName,

        [Parameter(
            ValueFromPipeline = $true,
            Position = 1
        )]
        [string]
        $Description,

        [Parameter()]
        [guid]
        $ID = (New-Guid).Guid,

        [Parameter()]
        [version]
        $TemplateVersion = "1.0.0",

        [Parameter()]
        [string]
        $Author = $env:USERNAME,

        [Parameter()]
        [string]
        $Title,

        [Parameter()]
        [string[]]
        $Tags
    )

    If (-not($Title))
    {
        $Title = $TemplateName
    }

    $Tags = $Tags -join ', '


    $metadata = @"
<metadata>
    <name>$($TemplateName)</name>
    <id>$($ID)</id>
    <version>$($TemplateVersion)</version>
    <title>$($Title)</title>
    <description>$($Description)</description>
    <author>$($Author)</author>
    <tags>$($Tags)</tags>
</metadata>
"@
    Write-Output -InputObject $metadata
}