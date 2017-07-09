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
            Choice -Label 'Data' -Help 'Adds a data folder to module root'
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
    }

    Content {
        NewModuleManifest {
            Destination = '${PLASTER_PARAM_ModuleName}.psd1'
            ModuleVersion = '$PLASTER_PARAM_ModuleVersion'
            RootModule = '${PLASTER_PARAM_ModuleName}.psm1'
            Author = '$PLASTER_PARAM_ModuleAuthor'
            description = '$PLASTER_PARAM_ModuleDesc'
        }

        TemplateFile -Source 'template.psm1' -Destination '${PLASTER_PARAM_ModuleName}.psm1'

        Message "Creating you folders for module: $PLASTER_PARAM_ModuleName"

        File -Source '' -Destination 'Public\' {
            $PLASTER_PARAM_FunctionFolders -contains 'Public'
        }

        File -Source '' -Destination 'Internal\' {
            $PLASTER_PARAM_FunctionFolders -contains 'Internal'
        }

        File -Source '' -Destination 'Classes\' {
            $PLASTER_PARAM_FunctionFolders -contains 'Classes'
        }

        File -Source '' -Destination 'Binaries\' {
            $PLASTER_PARAM_FunctionFolders -contains 'Binaries'
        }

        File -Source '' -Destination 'Data\' {
            $PLASTER_PARAM_FunctionFolders -contains 'Data'
        }

        Message "Creating a Tests folder" {
            $PLASTER_PARAM_Pester -eq "Yes"
        }

        RequireModule -Name "Pester" -MinimumVersion '3.4.0' {
            $PLASTER_PARAM_Pester -eq "Yes"
        }

        File -Source '' -Destination 'Tests\' {
            $PLASTER_PARAM_Pester -eq "Yes"
        }

        File -Source 'basicTest.ps1' -Destination 'Tests\${PLASTER_PARAM_ModuleName}.tests.ps1' {
            $PLASTER_PARAM_Pester -eq "Yes"
        }

        File -Source '.gitignore' -Destination '.gitignore' {
            $PlASTER_PARAM_Git -eq "Yes"
        }

        File -Source 'default.build.ps1' -Destination '${PLASTER_PARAM_ModuleName}.build.ps1' {
            $PLASTER_PARAM_InvokeBuild -eq "Yes"
        }

        RequireModule -Name 'InvokeBuild' {
            $PLASTER_PARAM_InvokeBuild -eq 'Yes'
        }
    }
}  |
    Export-PlasterManifest -Destination C:\temp\plasterManifest.xml -Verbose -PassThru |
    % {Code $psitem.fullname}
