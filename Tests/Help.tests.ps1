Describe 'Help' {
    BeforeAll {
        $moduleRoot = Split-Path -Path $PSScriptRoot
        $docFolder = Join-Path -Path $moduleRoot -ChildPath 'Docs'
        $docs = Get-ChildItem -Path $docFolder -Filter '*.md'

        $docTestCases = foreach ($doc in $docs)
        {
            @{
                DocName = $doc.BaseName
                FullPath = $doc.FullName
            }
        }
    }

    It 'Has all PlatyPS placeholders removed: <DocName>' -TestCases $docTestCases {
        param ($docName, $FullPath)
        $platyPlaceHolders = Select-String -Path $FullPath -SimpleMatch -Pattern '{{' |
            Measure-Object
        $platyPlaceHolders.Count | Should Be 0
    }
}