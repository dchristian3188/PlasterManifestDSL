PlasterManifest {
    Metadata {
        TemplateName = "ModuleTemplate"
        Title = "DC Custom Module Template"
        Description = "Plaster template to create a module"
        Author = "David Christian"
    }
    Parameters {

        UserFullName -Name "ModuleAuthor" -Prompt "Author"

        Text -Name "ModuleName" -Prompt "Name of your module"

        Text -Name "ModuleVersion" -Prompt "Version Number" -Default '0.0.0.1'

        Text -Name "ModuleDesc" -Prompt "Brief Description of your module"

        MultiChoice -Name "FunctionFolders" -Prompt "Please select folders to include" -Default "0,1,2" {
            Choice -Label 'Public' -Help 'Adds a public folder to module root'
            Choice -Label 'Internal' -Help 'Adds a internal folder to module root'
            Choice -Label 'Classes' -Help "Adds a classes folder to module root"
            Choice -Label 'Binaries' -Help 'Adds a binaries folder to module root'
            Choice -Label 'DSCResources' -Help 'Adds a DSCResource folder to module root'
        }

        SingleChoice -Name "Pester" -Prompt "Include Pester Tests?" -Default 0 {
            Choice -Label "Yes" -Help "Adds a tests folder"
            Choice -Label "No" -Help "Does not add a tests folder"
        }

        SingleChoice -Name "Git" -Prompt "Include GIt Support?" -Default 0 {
            Choice -Label "Yes" -Help "Includes Git files"
            Choice -Label "No" -Help "Does not include git files"
        }

        SingleChoice -Name "InvokeBuild" -Prompt "Include InvokeBuild Script" -Default 0 {
            Choice -Label "Yes" -Help "Adds an invoke build script at the root of module"
            Choice -Label "No" -Help "Does not include any invoke build scripts"
        }

        SingleChoice -Name "PSGraph" -Prompt "Include PSGraph" -Default 0 {
            Choice -Label "Yes" -Help "Adds a PSGraph diagram"
            Choice -Label "No" -Help "Does not add PSGraph support"
        }

        SingleChoice -Name "PlatyPS" -Prompt "Include PlatyPS" -Default 0 {
            Choice -Label "Yes" -Help "Adds a PlatyPS for help"
            Choice -Label "No" -Help "Does not add PlatyPS support"
        }
    }

    Content {

        Message -Message "Setting up your project"

        NewModuleManifest {
            Destination = '${PLASTER_PARAM_ModuleName}\${PLASTER_PARAM_ModuleName}.psd1'
            ModuleVersion = '$PLASTER_PARAM_ModuleVersion'
            RootModule = '${PLASTER_PARAM_ModuleName}.psm1'
            Author = '$PLASTER_PARAM_ModuleAuthor'
            description = '$PLASTER_PARAM_ModuleDesc'
        }

        TemplateFile -Source 'template.psm1' -Destination '${PLASTER_PARAM_ModuleName}\${PLASTER_PARAM_ModuleName}.psm1'

        Message "Creating you folders for module: $PLASTER_PARAM_ModuleName"

        File -Source '' -Destination '${PLASTER_PARAM_ModuleName}\Public\' {
            $PLASTER_PARAM_FunctionFolders -contains 'Public'
        }

        File -Source '' -Destination '${PLASTER_PARAM_ModuleName}\Internal\' {
            $PLASTER_PARAM_FunctionFolders -contains 'Internal'
        }

        File -Source '' -Destination '${PLASTER_PARAM_ModuleName}\Classes\' {
            $PLASTER_PARAM_FunctionFolders -contains 'Classes'
        }

        File -Source '' -Destination '${PLASTER_PARAM_ModuleName}\Binaries\' {
            $PLASTER_PARAM_FunctionFolders -contains 'Binaries'
        }

        File -Source '' -Destination '${PLASTER_PARAM_ModuleName}\DSCResources\' {
            $PLASTER_PARAM_FunctionFolders -contains 'DSCResources'
        }

        Message "Setting up support for Pester" {
            $PLASTER_PARAM_Pester -eq "Yes"
        }

        RequireModule -Name "Pester" -MinimumVersion '3.4.0' {
            $PLASTER_PARAM_Pester -eq "Yes"
        }

        File -Source '' -Destination '${PLASTER_PARAM_ModuleName}\Tests\' {
            $PLASTER_PARAM_Pester -eq "Yes"
        }

        File -Source 'basicTest.ps1' -Destination '${PLASTER_PARAM_ModuleName}\Tests\${PLASTER_PARAM_ModuleName}.tests.ps1' {
            $PLASTER_PARAM_Pester -eq "Yes"
        }

        Message "Setting up support for Git" {
            $PlASTER_PARAM_Git -eq "Yes"
        }

        TemplateFile -Source 'README.md' -Destination '${PLASTER_PARAM_ModuleName}\README.md' {
            $PLASTER_PARAM_Git -eq "Yes"
        }

        File -Source '.gitignore' -Destination '${PLASTER_PARAM_ModuleName}\.gitignore' {
            $PlASTER_PARAM_Git -eq "Yes"
        }

        Message "Setting up support for Invoke-Build" {
            $PLASTER_PARAM_InvokeBuild -eq "Yes"
        }

        RequireModule -Name 'InvokeBuild' {
            $PLASTER_PARAM_InvokeBuild -eq 'Yes'
        }

        TemplateFile -Source 'default.build.ps1' -Destination '${PLASTER_PARAM_ModuleName}\${PLASTER_PARAM_ModuleName}.build.ps1' {
            $PLASTER_PARAM_InvokeBuild -eq "Yes"
        }

        Message "Setting up support for PSGraph" {
            $PLASTER_PARAM_PSGraph -eq "Yes"
        }

        RequireModule -Name 'PSGraph' {
            $PLASTER_PARAM_PSGraph -eq 'Yes'
        }

        File -Source '' -Destination '${PLASTER_PARAM_ModuleName}\Graphs' {
            $PLASTER_PARAM_PSGraph -eq 'Yes'
        }

        File -Source 'CommandFlow.ps1' -Destination '${PLASTER_PARAM_ModuleName}\Graphs\CommandFlow.ps1' {
            $PLASTER_PARAM_PSGraph -eq 'Yes'
        }

        Message "Setting up support for PlatyPS" {
            $PLASTER_PARAM_PlatyPS -eq "Yes"
        }

        RequireModule -Name 'PlatyPS' {
            $PLASTER_PARAM_PlatyPS -eq 'Yes'
        }

        File -Source '' -Destination '${PLASTER_PARAM_ModuleName}\Help' {
            $PLASTER_PARAM_PlatyPS -eq 'Yes'
        }
    }
}  |  Export-PlasterManifest -Destination C:\temp\plasterManifest.xml -Verbose -PassThru |
    % {Code $psitem.fullname}
