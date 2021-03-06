task . Clean, Build, Tests, GenerateGraph, Help
task Tests ImportCompipledModule, Pester
task CreateManifest copyPSD, UpdateDSCResourceToExport
task Build Compile, CreateManifest
task Help CreateInitialHelpDocs, UpdateHelpDocs, GenerateExternalHelp


$script:ModuleName = Split-Path -Path $PSScriptRoot -Leaf
$script:ModuleRoot = $PSScriptRoot
$script:OutPutFolder = "$PSScriptRoot\Output"
$script:ImportFolders = @('Public', 'Internal', 'Classes', 'DSCResources')
$script:PsmPath = Join-Path -Path $PSScriptRoot -ChildPath "Output\$($script:ModuleName)\$($script:ModuleName).psm1"
$script:PsdPath = Join-Path -Path $PSScriptRoot -ChildPath "Output\$($script:ModuleName)\$($script:ModuleName).psd1"
$script:DSCResourceFolder = 'DSCResources'


task "Clean" {
    if (-not(Test-Path $script:OutPutFolder))
    {
        New-Item -ItemType Directory -Path $script:OutPutFolder > $null
    }

    Remove-Item -Path "$($script:OutPutFolder)\*" -Force -Recurse
}

$compileParams = @{
    Inputs = {
        foreach ($folder in $script:ImportFolders)
        {
            Get-ChildItem -Path $folder -Recurse -File -Filter '*.ps1'
        }
    }

    Output = {
        $script:PsmPath
    }
}

task Compile @compileParams {
    if (Test-Path -Path $script:PsmPath)
    {
        Remove-Item -Path $script:PsmPath -Recurse -Force
    }
    New-Item -Path $script:PsmPath -Force > $null

    foreach ($folder in $script:ImportFolders)
    {
        $currentFolder = Join-Path -Path $script:ModuleRoot -ChildPath $folder
        Write-Verbose -Message "Checking folder [$currentFolder]"

        if (Test-Path -Path $currentFolder)
        {
            $files = Get-ChildItem -Path $currentFolder -File -Filter '*.ps1'
            foreach ($file in $files)
            {
                Write-Verbose -Message "Adding $($file.FullName)"
                Get-Content -Path $file.FullName >> $script:PsmPath
            }
        }
    }
}

task CopyPSD {
    $copy = @{
        Path        = "$($script:ModuleName).psd1"
        Destination = $script:PsdPath
        Force       = $true
    }
    Copy-Item @copy
}

task UpdateDSCResourceToExport -if (Test-Path -Path $script:DSCResourceFolder) {
    $resources = (Get-ChildItem -Path $script:DSCResourceFolder |
            Select-Object -ExpandProperty BaseName) -join "', '"

    $resources = "'{0}'" -f $resources

    (Get-Content -Path $script:PsdPath) -replace "'_ResourcesToExport_'", $resources |
        Set-Content -Path $script:PsdPath
}

task ImportCompipledModule {
    Get-Module -Name $script:ModuleName |
        Remove-Module -Force
    Import-Module -Name $script:PsdPath -Force
}

task Pester {
    $resultFile = "{0}\testResults{1}.xml" -f $script:OutPutFolder, (Get-date -Format 'yyyyMMdd_hhmmss')
    $testFolder = Join-Path -Path $PSScriptRoot -ChildPath 'Tests\*'
    Invoke-Pester -Path $testFolder -OutputFile $resultFile -OutputFormat NUnitxml
}

task GenerateGraph -if (Test-Path -Path 'Graphs') {
    $graphPath = Join-Path -Path $(Split-Path -Path $script:PsmPath) -ChildPath "ModuleFlow.png"
    .\Graphs\MethodFlow.ps1 -OutputPath $graphPath  -Quiet > $null

     $graphPath = Join-Path -Path $(Split-Path -Path $script:PsmPath) -ChildPath "PropertyFlow.png"
     .\Graphs\PropertyFlow.ps1 -OutputPath $graphPath -Quiet -CompiledModule $script:PsmPath > $null
}

task CreateInitialHelpDocs -if (-not(Test-Path -Path 'Docs')) {
    New-MarkdownHelp -OutputFolder $PSScriptRoot\Docs -WithModulePage -Module $script:ModuleName
}

$docParams = @{
    Inputs = {
        foreach ($folder in $script:ImportFolders)
        {
            Get-ChildItem -Path $folder -Recurse -File -Filter '*.ps1'
        }
    }

    Output = {
        Get-ChildItem -Path "$PSScriptRoot\Docs\*" -Filter "*md"
    }
}
task UpdateHelpDocs @docParams {
    Update-MarkdownHelp -Path .\Docs -AlphabeticParamsOrder
}

task GenerateExternalHelp {
    $helpOutput = [IO.Path]::Combine($PSScriptRoot,'Output',$script:ModuleName,'en-US\')
    New-ExternalHelp -Path $PSScriptRoot\Docs -OutputPath $helpOutput
}