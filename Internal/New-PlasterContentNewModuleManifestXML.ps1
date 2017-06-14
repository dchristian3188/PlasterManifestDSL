Function New-PlasterContentNewModuleManifestXML
{
    [CmdletBinding()]
    param(
        [Parameter(
            ValueFromPipeline = $true
        )]
        [scriptblock]
        $Condition,

        [Parameter(
            ValueFromPipeline = $true,
            Mandatory = $true
        )]
        [string]
        $Destination,

        [Parameter(
            ValueFromPipeline = $true
        )]
        [string]
        $Author,

        [Parameter(
            ValueFromPipeline = $true
        )]
        [string]
        $Description,

        [Parameter(
            ValueFromPipeline = $true
        )]
        [string]
        $CompanyName,

        [Parameter(
            ValueFromPipeline = $true
        )]
        [string]
        $ModuleVersion,

        [Parameter(
            ValueFromPipeline = $true
        )]
        [string]
        $RootModule,


        [Parameter(
            ValueFromPipeline = $true
        )]
        [ValidateSet('Default','Ascii','BigEndianUnicode','BigEndianUTF32','Oem','Unicode','UTF32','UTF7','UTF8','UTF8-NoBOM')]
        [string]
        $Encoding,

        [Parameter(
            ValueFromPipeline = $true
        )]
        [string]
        $OpenInEditor,

        [Parameter(
            ValueFromPipeline = $true
        )]
        [string]
        $PowershellVersion,

        [Parameter(
            ValueFromPipeline = $true
        )]
        [string]
        $NestedModules,

        [Parameter(
            ValueFromPipeline = $true
        )]
        [string]
        $DscResourcesToExport

    )

    $manifestSB = [System.Text.StringBuilder]::new("<newModuleManifest ")

    ForEach($parameter in $PSBoundParameters.Keys)
    {
        if($parameter -eq 'Condition')
        {
            $conditionString = New-Condition -Condition $Condition
            $manifestSB.AppendLine("condition=$conditionString") > $null
        }
        else
        {
            $propertyName = "{0}{1}" -f ($parameter[0]).ToString().ToLower(),$parameter.SubString(1)
            $manifestSB.AppendLine("$propertyName='$($PSBoundParameters[$parameter])'") > $null
        }
    }

    $manifestSB.Append("/>") > $null
    Write-Output -InputObject $manifestSB.ToString()
}